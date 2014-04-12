//
//  NSFileManager+WWFileManager.h
//  WWFoundation
//
//  Created by William Wu on 4/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (WWFoundation)

- (NSURL *) cacheURL;
- (NSURL *) documentURL;
- (NSURL *) temporaryURL;

- (NSString *) cachePath;
- (NSString *) documentPath;
- (NSString *) temporaryPath;

- (NSString *)fullPath:(NSString *)path fileName:(NSString *)fileName;

@end
