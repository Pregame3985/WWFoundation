//
//  WWBaseService.h
//  Echo
//
//  Created by William Wu on 4/17/14.
//  Copyright (c) 2014 The eve of the Shanghai information technology co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

extern NSString *const kEchoErrorDomain;

typedef NS_ENUM(NSUInteger, RESTfulMethod)
{
    RESTFUL_METHOD_GET = 0,
    RESTFUL_METHOD_POST = 1,
	RESTFUL_METHOD_PUT = 2,
	RESTFUL_METHOD_DELETE = 3
};

typedef void (^MultiActionBlock) (NSDictionary *result, NSError *error);

@interface WWBaseNetService : NSObject

@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, strong) MultiActionBlock actionBlock;
@property (nonatomic, strong) NSMutableDictionary *actionBlocks;
@property (nonatomic, getter = isNetworkAvailable) BOOL networkAvailable;

- (void) didReceiveMemoryWarning;

+ (instancetype)sharedInstance;

+ (NSURL *) getAction:(NSString *)actionName;

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


@end
