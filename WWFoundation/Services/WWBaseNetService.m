//
//  WWBaseService.m
//  WWFoundation
//
//  Created by William Wu on 4/17/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseNetService.h"
#import "Reachability.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "OEMonitorService.h"
#import "WWConfiguration.h"
#import "ASIDownloadCache.h"
#import "JSONKit.h"

NSString *const kNetworkErrorDomain = @"com.rippling.network.error";

@interface WWParams ()

@property (nonatomic, strong) NSMutableDictionary *wwParams;

@end

@implementation WWParams

- (NSMutableDictionary *)wwParams
{
    if (!_wwParams)
    {
        _wwParams = [[NSMutableDictionary alloc] init];
    }
    
    return _wwParams;
}

- (void)addAuth:(NSString *)access
{
    if (access.length > 0)
    {
        [self addParam:@"access" value:access];
    }
    else
    {
        @throw([NSException exceptionWithName:@"Not Auth" reason:@"Not Auth" userInfo:nil]);
    }
}

- (void)addParam:(NSString *)key value:(NSObject *)value
{
    if (key.length > 0 && value)
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            value = [((NSNumber *)value) stringValue];
        }
        [self.wwParams setObject:value forKey:key];
    }
}

- (void)addParam:(NSString *)key values:(NSArray *)values
{
    if (key.length > 0 && values.count > 0)
    {
        [self.wwParams setObject:values forKey:key];
    }
}

- (void)addParams:(NSString *)key values:(NSArray *)values
{
    if (key.length > 0 && values.count > 0)
    {
        for (int i = 0; i < values.count; i++)
        {
            NSString *paramKey = [NSString stringWithFormat:@"%@[%d]", key, i];
            NSObject *paramValue = values[i];
            
            [self addParam:paramKey value:paramValue];
        }
    }
}

- (NSMutableDictionary *)params
{
    return [self wwParams];
}

@end

@interface WWBaseNetService () <ASIHTTPRequestDelegate>

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) OEMonitorService *monitorService;
@property (nonatomic, strong) NSMutableDictionary *apiMonitors;
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic) BOOL hasNetworkChanged;

@end

@implementation WWBaseNetService


- (void) didReceiveMemoryWarning
{
    DLog(@"Class %@ - %@ invoke", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static WWBaseNetService *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        self.version     = @"";
        self.timeout     = 45.0f;
        self.monitorService = [[OEMonitorService alloc] init];
        self.actionBlocks = [@{} mutableCopy];
        self.apiMonitors = [@{} mutableCopy];
        
        self.networkAvailable = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNetworkChange)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        [self setReachability:[Reachability reachabilityForInternetConnection]];
        [self.reachability startNotifier];
    }
    
    return self;
}

- (void) updateMonitorState:(NSURL *)actionURL lastUpdateTime:(NSDate *)lastUpdateTime
{
    OEMonitorInfo *monitorInfo = [self.monitorService monitorAction:actionURL
                                                     lastUpdateTime:lastUpdateTime];
    
    self.apiMonitors[monitorInfo.hash_key] = monitorInfo;
}

- (NSURL *) getAction:(NSString *)actionName params:(NSDictionary *)params
{
    NSString *theActionName = actionName;
    if (self.version.length > 0)
    {
        theActionName = [[self.netServiceDelegate domainHost] stringByAppendingFormat:@"/v%@%@", self.version, actionName];
    }
    else
    {
        theActionName = [[self.netServiceDelegate domainHost] stringByAppendingFormat:@"%@", actionName];
    }
    
    if (params.count > 0)
    {
        NSMutableArray *querys = [@[] mutableCopy];
        
        for (NSString *key in [params allKeys])
        {
            id value = params[key];
            
            if ([value isKindOfClass:[NSString class]])
            {
                NSString *stringValue = value;
                if (stringValue.length > 0)
                {
                    NSString *query = [NSString stringWithFormat:@"%@=%@", key, [stringValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    [querys addObject:query];
                }
            }
            else if ([value isKindOfClass:[NSArray class]])
            {
                NSArray *arrayValues = value;
                for (NSString *stringValue in arrayValues)
                {
                    if (stringValue.length > 0)
                    {
                        NSString *query = [NSString stringWithFormat:@"%@=%@", key, [stringValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                        [querys addObject:query];
                    }
                }
            }
        }
        
        NSString *queryString = [querys componentsJoinedByString:@"&"];
        
        if (queryString.length > 0)
        {
            theActionName = [theActionName stringByAppendingFormat:@"?%@", queryString];
        }
    }
    
    NSURL *url = [NSURL URLWithString:theActionName];
    
#ifdef API_ENVIRONMENT_DEVELOPMENT
    DLog(@"Request URL %@", url);
    DLog(@"Request Params %@", [params description]);
#endif
    
    return url;
}

- (NSURL *) getAction:(NSString *)actionName
{
    return [self getAction:actionName params:nil];
}

- (NSString *) methodString:(RESTfulMethod)method
{
    switch (method)
    {
        case RESTFUL_METHOD_POST:
            return @"POST";
            
        case RESTFUL_METHOD_PUT:
            return @"PUT";
            
        case RESTFUL_METHOD_DELETE:
            return @"DELETE";
            
        default:
            break;
    }
    
    return @"GET";
}

- (ASIHTTPRequest *)createGetRequest:(NSString *)actionName data:(NSDictionary *)data
{
    NSURL *url = [self getAction:actionName params:data];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:[self methodString:RESTFUL_METHOD_GET]];
    
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];
    [request setSecondsToCache:30];
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy | ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request setDelegate:self];
    [request setTimeOutSeconds:self.timeout];
    
    return request;
}

- (ASIHTTPRequest *)createPostRequest:(NSString *)actionName data:(id)data
{
    NSURL *url = [self getAction:actionName];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-type" value:@"application/x-www-form-urlencoded"];
    [request setDelegate:self];
    [request setTimeOutSeconds:self.timeout];
    
    for (NSString *key in [((NSMutableDictionary *)data) allKeys])
    {
        [request setPostValue:((NSMutableDictionary *)data)[key] forKey:key];
    }
    
    //    NSString *postString;
    
    //    if ([data isKindOfClass:[NSDictionary class]])
    //    {
    //        OEUserInfo *userInfo = [OEAppDelegate sharedAppDelegate].userInfo;
    //
    //        NSString *hashKey = [NSString stringWithFormat:@"%@+%d", url.absoluteString, userInfo.id.intValue].md5;
    //
    //        OEMonitorInfo *apiMonitor = [OEAppDelegate sharedAppDelegate].apiMonitors[hashKey];
    //
    //        NSMutableDictionary *mutableData = [data mutableCopy];
    //
    //        if (![actionName isEqualToString:kSearchConfAction])
    //        {
    //            if (apiMonitor)
    //            {
    //                mutableData[@"last_update_time"] = @(apiMonitor.last_update_time.timeIntervalSince1970);
    //            }
    //            else
    //            {
    //                mutableData[@"last_update_time"] = @(0);
    //            }
    //        }
    //
    //        postString = mutableData.JSONString;
    //    }
    //    else if ([data isKindOfClass:[NSArray class]])
    //    {
    //        postString = ((NSArray *)data).JSONString;
    //    }
    //    else
    //    {
    //        assert(@"Params invalid");
    //    }
    
    //#ifdef API_ENVIRONMENT_DEVELOPMENT
    //    DLog(@"Post data %@", postString);
    //#endif
    //
    //    [request appendPostData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

- (ASIHTTPRequest *)createPutRequest:(NSString *)actionName data:(id)data
{
    NSURL *url = [self getAction:actionName];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-type" value:@"application/x-www-form-urlencoded"];
    [request setRequestMethod:[self methodString:RESTFUL_METHOD_PUT]];
    [request setDelegate:self];
    [request setTimeOutSeconds:self.timeout];
    
    for (NSString *key in [((NSMutableDictionary *)data) allKeys])
    {
        [request setPostValue:((NSMutableDictionary *)data)[key] forKey:key];
    }
    
    return request;
}

- (ASIHTTPRequest *)createDeleteRequest:(NSString *)actionName data:(NSDictionary *)data
{
    NSURL *url = [self getAction:actionName params:data];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setRequestMethod:[self methodString:RESTFUL_METHOD_DELETE]];
    
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];
    [request setSecondsToCache:30];
    [request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy | ASIAskServerIfModifiedWhenStaleCachePolicy];
    [request setDelegate:self];
    [request setTimeOutSeconds:self.timeout];
    
    return request;
}

- (void) getActionWithActionName:(NSString *)actionName
                          params:(NSDictionary *)params
                        complete:(MultiActionBlock)complete
{
    if (self.isNetworkAvailable)
    {
        ASIHTTPRequest *request = [self createGetRequest:actionName data:params];
        
        [self.actionBlocks setObject:complete forKey:request.url];
        
        [request startAsynchronous];
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络无法连接"};
        NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
        
        if (complete)
        {
            complete(nil, error);
        }
    }
}

- (void) getActionWithActionName:(NSString *)actionName
                          params:(NSDictionary *)params
                progressDelegate:(id<ASIProgressDelegate>)progressDelegate
                        complete:(MultiActionBlock)complete
{
    if (self.isNetworkAvailable)
    {
        ASIHTTPRequest *request = [self createGetRequest:actionName data:params];
        
        [request setDownloadProgressDelegate:progressDelegate];
        [request setShowAccurateProgress:YES];
        [self.actionBlocks setObject:complete forKey:request.url];
        
        [request startAsynchronous];
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络无法连接"};
        NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
        
        if (complete)
        {
            complete(nil, error);
        }
    }
}

- (void) postActionWithActionName:(NSString *)actionName
                           params:(id)params
                         complete:(MultiActionBlock)complete
{
    if (self.isNetworkAvailable)
    {
        ASIHTTPRequest *request = [self createPostRequest:actionName data:params];
        
        [self.actionBlocks setObject:complete forKey:request.url];
        
        [request startAsynchronous];
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络无法连接"};
        NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
        
        if (complete)
        {
            complete(nil, error);
        }
    }
}

- (void) putActionWithActionName:(NSString *)actionName
                           params:(id)params
                         complete:(MultiActionBlock)complete
{
    if (self.isNetworkAvailable)
    {
        ASIHTTPRequest *request = [self createPutRequest:actionName data:params];
        
        [self.actionBlocks setObject:complete forKey:request.url];
        
        [request startAsynchronous];
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络无法连接"};
        NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
        
        if (complete)
        {
            complete(nil, error);
        }
    }
}

- (void) deleteActionWithActionName:(NSString *)actionName
                             params:(id)params
                           complete:(MultiActionBlock)complete
{
    if (self.isNetworkAvailable)
    {
        ASIHTTPRequest *request = [self createDeleteRequest:actionName data:params];
        
        [self.actionBlocks setObject:complete forKey:request.url];
        
        [request startAsynchronous];
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络无法连接"};
        NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
        
        if (complete)
        {
            complete(nil, error);
        }
    }
}

#pragma - ASIHTTPRequestDelegate
- (void) requestFinished:(ASIHTTPRequest *)request
{
#ifdef API_DEBUG
    DLog(@"网络请求返回的数据:%@",request.responseString);
#endif
    
    NSDictionary *responseObject = [request.responseString objectFromJSONString];
    
    MultiActionBlock actionBlock = self.actionBlocks[request.url];
    
    if (!responseObject)
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络连接出错"};
        NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
        
        if (actionBlock)
        {
            actionBlock(nil, error);
        }
    }
    else
    {
        if ([responseObject[@"state"] integerValue] == 1)
        {
            NSDictionary *extra = responseObject[@"extra"];
            if (extra)
            {
                NSNumber *timeInterval = extra[@"last_update_time"];
                NSDate *lastUpdateTime = [NSDate dateWithTimeIntervalSince1970:timeInterval.doubleValue];
                [self updateMonitorState:request.url lastUpdateTime:lastUpdateTime];
            }
            
            if (actionBlock)
            {
                actionBlock(responseObject, nil);
            }
        }
        else
        {
            if ([responseObject[@"error"][@"code"] isEqualToString:@"/access_001"])
            {
                if (self.notLoginActionBlock)
                {
                    self.notLoginActionBlock(nil, nil);
                }
            }
            else
            {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : responseObject[@"error"][@"message"]};
                NSError *error = [NSError errorWithDomain:kNetworkErrorDomain code:500 userInfo:userInfo];
                if (actionBlock)
                {
                    actionBlock(nil, error);
                }
            }
        }
    }
    
    [self.actionBlocks removeObjectForKey:request.url];
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
    MultiActionBlock actionBlock = self.actionBlocks[request.url];
    
    if (actionBlock)
    {
        NSError *error = [request error];
        
        NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
        
        if ([error.domain isEqualToString:NetworkRequestErrorDomain])
        {
            if (error.code == 1)
            {
                userInfo[NSLocalizedDescriptionKey] = @"无法连接网络，请检查您的网络是否可用。";
            }
            else if (error.code == 2)
            {
                userInfo[NSLocalizedDescriptionKey] = @"当前服务不可用，请稍后再试。";
            }
            
            NSError *newError = [NSError errorWithDomain:error.domain
                                                    code:error.code
                                                userInfo:[userInfo copy]];
            
            actionBlock(nil, newError);
        }
        else
        {
            actionBlock(nil, error);
        }
        
        [self.actionBlocks removeObjectForKey:request.url];
    }
}

- (void) handleNetworkChange
{
    self.hasNetworkChanged = YES;
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable)
    {
        //show network alert
        self.networkAvailable = NO;
        DLog(@"NO NETWORK !!!");
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        self.networkAvailable = YES;
        DLog(@"NETWORK via WIFI");
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        self.networkAvailable = YES;
        DLog(@"NETWORK via CELL");
    }
    
}

@end
