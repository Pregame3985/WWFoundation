//
//  OEMonitorInfo.m
//  RocheRubik
//
//  Created by William Wu on 2/1/14.
//  Copyright (c) 2014 Oneve. All rights reserved.
//

#import "OEMonitorInfo.h"

@implementation OEMonitorInfo

- (NSString *) hash_key
{
//    if ([NSString emptyString:_hash_key])
//    {
//        _hash_key = [NSString stringWithFormat:@"%@+%d", self.url, self.user_id.intValue].md5;
//    }
//    
    return _hash_key;
}

@end
