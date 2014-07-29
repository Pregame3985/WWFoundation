//
//  WWBaseLocalService.m
//  RipplingApp
//
//  Created by William Wu on 7/29/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "WWBaseLocalService.h"

@implementation WWBaseLocalService

- (void)save:(id<WWItemDataDelegate>)item
{
    [self save:item dataStore:nil];
}

@end
