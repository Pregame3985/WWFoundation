//
//  WWYoukuService.h
//  WWFoundation
//
//  Created by William Wu on 4/28/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseNetService.h"
#import "WWBaseInfo.h"

extern NSString *const kAuthorizeURL;
extern NSString *const kCreateURL;

#define YOUKU_CLIENT_ID             @"fedb4023b41e926f"
#define YOUKU_CLIENT_SECRET         @"61e2487361071e6f7da67ebb86ad141f"
#define YOUKU_REDIRECT_URI          @"http://112.124.0.97:8222/callback.php"
#define YOUKU_API_HOST              @"http://openapi.youku.com"

@interface YoukuCredential : WWBaseInfo

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *expires_in;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *token_type;

@end

@interface WWYoukuService : WWBaseNetService

+ (instancetype)sharedInstance;
- (void)authorize;
- (void)acceptRequestToken:(NSDictionary *)params;

@end
