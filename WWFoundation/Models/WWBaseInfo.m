//
//  OEBaseModelObject.m
//  RocheRubik
//
//  Created by William Wu on 1/30/14.
//  Copyright (c) 2014 Oneve. All rights reserved.
//

#import "WWBaseInfo.h"
#import <objc/runtime.h>
#import "NSManagedObject+InnerBand.h"

@implementation WWKeyValueInfo

@end

@implementation WWBaseInfo

@synthesize id = _id;
@synthesize uuid = _uuid;
@synthesize created_time = _created_time;
@synthesize updated_time = _updated_time;
@synthesize published_time = _published_time;

- (id) toCoreDataEntity:(Class)entityType inStore:(IBCoreDataStore *)dataStore
{
	return [self updateCoreDataEntity:[entityType createInStore:dataStore]];
}

- (id)updateCoreDataEntity:(NSManagedObject *)entity
{
	Class class = [self class];
    
	if (entity)
	{
		Class entityType = [entity class];
        
		while (class != [NSObject class] && class != nil)
		{
			uint count;
            
			objc_property_t *properties = class_copyPropertyList(class, &count);
            
			for (int i = 0; i < count; i++)
			{
				NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
                
				//skip nil property
				if (class_getProperty(entityType, [key UTF8String]) == nil)
				{
					continue;
				}
                
                id value = [self valueForKey:key];
                
                if ([value isKindOfClass:[NSNull class]])
                {
                    continue;
                }
                
				[entity setValue:value forKey: key];
			}
            
			free(properties);
            
			class = class_getSuperclass(class);
		}
	}
    
	return entity;
}


+ (id) fromCoreDataEntity:(NSManagedObject *)entity
{
	return [[[[self class] alloc] init] fromCoreDataEntity:entity];
}

- (id) fromCoreDataEntity:(NSManagedObject *)entity
{
	Class modelType = [self class];
    
	if (entity)
	{
		Class class = [entity class];
        
		while (class != [NSManagedObject class] && class != [NSObject class] && class != nil)
		{
			uint count = 0;
            
			objc_property_t *properties = class_copyPropertyList(class, &count);
            
			for (int i = 0; i < count; i++)
			{
				NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
                
				//skip nil property
				if (class_getProperty(modelType, [key UTF8String]) == nil)
				{
					continue;
				}
                
				NSString *valueKey = [NSString stringWithFormat:@"%@Value", key];
                
				if (class_getProperty(class, [valueKey UTF8String]))
				{
					[self setValue:[entity valueForKey:valueKey] forKey:key];
				}
				else
				{
					[self setValue:[entity valueForKey:key] forKey:key];
				}
			}
            
			free(properties);
            
			class = class_getSuperclass(class);
		}
	}
	return self;
}

+ (id) fromDictionary:(NSDictionary *)dictionary
{
    return [[[[self class] alloc] init] fromDictionary:dictionary];
}

- (id) fromDictionary:(NSDictionary *)dictionary
{
    Class class = [self class];
    
    while (class != [NSObject class] && class != nil)
    {
        uint count = 0;
        
        objc_property_t *properties = class_copyPropertyList(class, &count);
        
        for (int i = 0; i < count; i++)
        {
            NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
            
            //skip nil property
            if (![dictionary valueForKey:key])
            {
                continue;
            }
            
            [self setValue:[dictionary valueForKey:key] forKey:key];
        }
        
        free(properties);
        
        class = class_getSuperclass(class);
    }
    
    return self;
}

@end
