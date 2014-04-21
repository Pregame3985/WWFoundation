//
//  OEMonitorService.m
//  RocheRubik
//
//  Created by William Wu on 2/1/14.
//  Copyright (c) 2014 Oneve. All rights reserved.
//

#import "OEMonitorService.h"
//#import "NSString+Hashes.h"

@implementation OEMonitorService

- (void)didReceiveMemoryWarning
{
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSMutableDictionary *)loadAllMonitors
{
#ifdef API_ENVIRONMENT_DEVELOPMENT
//    [Monitor destroyAll];
#endif
    
//    OEUserInfo *user = [OEAppDelegate sharedAppDelegate].userInfo;
//    
//    NSArray *monitors = [Monitor allForPredicate:[NSPredicate predicateWithFormat:@"user_id == %d", user.id.intValue]];
//    
//    NSMutableDictionary *allMonitors = [NSMutableDictionary dictionary];
//    
//    for (Monitor *monitor in monitors)
//    {
//        OEMonitorInfo *monitorInfo = [OEMonitorInfo new];
//        
//        [monitorInfo fromCoreDataEntity:monitor];
//        
//        if (![NSString emptyString:monitorInfo.hash_key])
//        {
//            allMonitors[monitorInfo.hash_key] = monitorInfo;
//        }
//    }
//    
//    return allMonitors;
    return nil;
}

- (OEMonitorInfo *) monitorAction:(NSURL *)actionURL lastUpdateTime:(NSDate *)lastUpdateTime
{
//    OEUserInfo *userInfo = [OEAppDelegate sharedAppDelegate].userInfo;
//    
//    OEMonitorInfo *monitorInfo = [OEMonitorInfo new];
//    monitorInfo.url = actionURL.absoluteString;
//    monitorInfo.last_update_time = lastUpdateTime;
//    monitorInfo.user_id = userInfo.id;
//    
//    IBCoreDataStore *dataStroe = [IBCoreDataStore createStore];
//    
//    Monitor *monitor = [Monitor firstWithKey:@"hash_key" value:monitorInfo.hash_key inStore:dataStroe];
//    
//    if (monitor)
//    {
//        [monitorInfo updateCoreDataEntity:monitor];
//    }
//    else
//    {
//        [monitorInfo toCoreDataEntity:[Monitor class] inStore:dataStroe];
//    }
//    
//    [dataStroe save];
//    
//    return monitorInfo;
    return nil;
}

@end
