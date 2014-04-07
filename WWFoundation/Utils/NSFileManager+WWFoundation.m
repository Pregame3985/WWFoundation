//
//  NSFileManager+WWFileManager.m
//  WWFoundation
//
//  Created by William Wu on 4/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "NSFileManager+WWFoundation.h"

@implementation NSFileManager (WWFoundation)

- (NSURL *) cacheURL
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return [NSURL fileURLWithPathComponents:paths];
}

- (NSURL *) documentURL
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [NSURL fileURLWithPathComponents:paths];
}

- (NSURL *) temporaryURL
{
    return [NSURL fileURLWithPath:NSTemporaryDirectory()];
}

- (NSString *) cachePath
{
    return [[self cacheURL] path];
}

- (NSString *) documentPath
{
    return [[self documentURL] path];
}

- (NSString *) temporaryPath
{
    return NSTemporaryDirectory();
}

@end
