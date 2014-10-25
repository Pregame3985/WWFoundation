//
//  WWBaseService.h
//  WWFoundation
//
//  Created by William Wu on 4/17/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseService.h"
#import "ASIHTTPRequest.h"

extern NSString *const kNetworkErrorDomain;

typedef NS_ENUM(NSUInteger, RESTfulMethod)
{
    RESTFUL_METHOD_GET = 0,
    RESTFUL_METHOD_POST = 1,
	RESTFUL_METHOD_PUT = 2,
	RESTFUL_METHOD_DELETE = 3
};

typedef void (^MultiActionBlock) (NSDictionary *, NSError *);

@interface WWParams : NSObject

- (void)addAuth:(NSString *)access;
- (void)addParam:(NSString *)key value:(NSObject *)value;
- (void)addParam:(NSString *)key values:(NSArray *)values;
- (void)addParams:(NSString *)key values:(NSArray *)values;

- (NSDictionary *)params;

@end

@protocol WWBaseNetServiceDelegate <NSObject>

- (NSString *)domainHost;

@optional
- (NSString *)secretKey;
- (BOOL)resultCheck:(id)responseObject;

@end

@interface WWBaseNetService : WWBaseService

@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, strong) MultiActionBlock actionBlock;
@property (nonatomic, strong) MultiActionBlock notLoginActionBlock;
@property (nonatomic, strong) NSMutableDictionary *actionBlocks;
@property (nonatomic, getter = isNetworkAvailable) BOOL networkAvailable;
@property (nonatomic, assign) id<WWBaseNetServiceDelegate> netServiceDelegate;

- (void) didReceiveMemoryWarning;

+ (instancetype)sharedInstance;

- (NSURL *) getAction:(NSString *)actionName;

- (void) getActionWithActionName:(NSString *)actionName
                          params:(NSDictionary *)params
                        complete:(MultiActionBlock)complete;

- (void) getActionWithActionName:(NSString *)actionName
                          params:(NSDictionary *)params
                progressDelegate:(id<ASIProgressDelegate>)progressDelegate
                        complete:(MultiActionBlock)complete;

- (void) postActionWithActionName:(NSString *)actionName
                           params:(id)params
                         complete:(MultiActionBlock)complete;

- (void) putActionWithActionName:(NSString *)actionName
                          params:(id)params
                        complete:(MultiActionBlock)complete;

- (void) deleteActionWithActionName:(NSString *)actionName
                             params:(id)params
                           complete:(MultiActionBlock)complete;

@end
