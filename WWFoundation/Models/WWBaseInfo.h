//
//  OEBaseModelObject.h
//  RocheRubik
//
//  Created by William Wu on 1/30/14.
//  Copyright (c) 2014 Oneve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBCoreDataStore.h"

@protocol WWItemDataDelegate <NSObject>

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSNumber *created_time;
@property (nonatomic, strong) NSNumber *updated_time;
@property (nonatomic, strong) NSNumber *published_time;

@required
- (void)mapping:(id)data;

@end

@interface WWBaseInfo : NSObject <WWItemDataDelegate>

- (instancetype)parse:(NSString *)jsonObject;

@end

@interface WWBaseInfo (Utils)

- (id) toCoreDataEntity:(Class)entityType inStore:(IBCoreDataStore *)dataStore;
- (id) updateCoreDataEntity:(NSManagedObject *)entity;

+ (id) fromCoreDataEntity:(NSObject *)entity;
- (id) fromCoreDataEntity:(NSObject *)entity;

+ (id) fromDictionary:(NSDictionary *)dictionary;

@end

@interface WWKeyValueInfo : WWBaseInfo

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSObject *value;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;

@end
