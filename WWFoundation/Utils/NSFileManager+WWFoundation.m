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

- (BOOL) fileExistsAtPath:(NSString *)path fileName:(NSString *)fileName;
{
    NSString *fullPath;
    
    if (!path)
    {
        NSArray *fileNameArray = [fileName componentsSeparatedByString:@"."];
        
        if (!(fileNameArray.count >= 1 || fileNameArray.count <= 2))
        {
            return NO;
        }
        
        if (fileNameArray.count == 1)
        {
            fullPath = [[NSBundle mainBundle] pathForResource:fileNameArray[0] ofType:nil];
        }
        else
        {
            fullPath = [[NSBundle mainBundle] pathForResource:fileNameArray[0] ofType:fileNameArray[1]];
        }
    }
    else
    {
        fullPath = [[NSURL fileURLWithPathComponents:@[path, fileName]] path];
    }
    
    return [self fileExistsAtPath:fullPath isDirectory:NO];
}

@end
