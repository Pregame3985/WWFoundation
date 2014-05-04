//
//  OEMonitorInfo.h
//  RocheRubik
//
//  Created by William Wu on 2/1/14.
//  Copyright (c) 2014 Oneve. All rights reserved.
//

#import "WWBaseInfo.h"

@interface OEMonitorInfo : WWBaseInfo

@property (nonatomic, strong) NSDate *last_update_time;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *hash_key;
@property (nonatomic, strong) NSNumber *user_id;

@end
