//
//  WWYoukuService.m
//  WWFoundation
//
//  Created by William Wu on 4/28/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWYoukuService.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#include <netdb.h>
#include <sys/socket.h>
#include <arpa/inet.h>

NSString *const kAuthorizeURL = @"/v2/oauth2/authorize";
NSString *const kCreateURL = @"/v2/uploads/create.json";

@interface YoukuUploadFile : WWBaseInfo

@property (nonatomic, strong) NSString *upload_token;
@property (nonatomic, strong) NSString *upload_server_uri;

@end

@implementation YoukuUploadFile

@end

@implementation YoukuCredential

@end

@interface WWYoukuService ()

@property (nonatomic, strong) YoukuCredential *credential;

@end

@implementation WWYoukuService

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static WWYoukuService *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)authorize
{
    NSString *authorizeURLString = [NSString stringWithFormat:@"%@%@?client_id=%@&response_type=token&state=xyz&redirect_uri=%@", YOUKU_API_HOST, kAuthorizeURL, YOUKU_CLIENT_ID, YOUKU_REDIRECT_URI];
    
    NSURL *authorizeURL = [NSURL URLWithString:authorizeURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:authorizeURL])
    {
        [[UIApplication sharedApplication] openURL:authorizeURL];
    }
}

- (void)acceptRequestToken:(NSDictionary *)params
{
    self.credential = [YoukuCredential fromDictionary:params];
}

- (void)create:(NSDictionary *)params
{
    NSString *createURLString = [NSString stringWithFormat:@"%@%@?client_id=%@&access_token=%@&title=%@&tags=%@&file_md5=%@&file_name=%@&file_size=%d", YOUKU_API_HOST, kCreateURL, YOUKU_CLIENT_ID, self.credential.access_token, params[@"title"], params[@"tags"], params[@"md5"], params[@"name"], ((NSNumber *)params[@"size"]).intValue];
    
    NSURL *createURL = [NSURL URLWithString:createURLString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:createURL];
    __weak ASIHTTPRequest *weakRequest = request;
    
    /*
     { "upload_token": "1a2b3c4d", "instant_upload_ok": "no",
     "upload_server_uri": "g01.upload.youku.com" }
     */
    [request setCompletionBlock:^{
        NSDictionary *responseObject = [weakRequest.responseString objectFromJSONString];
        
        YoukuUploadFile *uploadFile = [YoukuUploadFile fromDictionary:responseObject];
    }];
    
    [request startAsynchronous];
}

- (void)createFile:(YoukuUploadFile *)uploadFile
{
    NSString *ipAddress = [self getIPWithHostName:uploadFile.upload_server_uri];
    
    NSString *createFileURLString = [NSString stringWithFormat:@"http://%@/gupload/create_file", ipAddress];
    
    NSURL *createFileURL = [NSURL URLWithString:createFileURLString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:createFileURL];
    __weak ASIHTTPRequest *weakRequest = request;
    
    [request setCompletionBlock:^{
        NSDictionary *responseObject = [weakRequest.responseString objectFromJSONString];
        
        YoukuUploadFile *uploadFile = [YoukuUploadFile fromDictionary:responseObject];
    }];
    
    [request startAsynchronous];
}

- (NSString *)getIPWithHostName:(NSString *)hostName
{
    const char *hostN = [hostName UTF8String];
    struct hostent* phot;
    
    @try {
        phot = gethostbyname(hostN);
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, phot->h_addr_list[0], 4);
    char ip[20] = {0};
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    
    NSString *strIPAddress = [NSString stringWithUTF8String:ip];
    return strIPAddress;
}

@end
