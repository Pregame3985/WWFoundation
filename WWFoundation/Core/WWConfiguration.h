//
//  WWConfiguration.h
//  WWFoundation
//
//  Created by William Wu on 1/25/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#ifndef WWFoundation_WWConfiguration_h
#define WWFoundation_WWConfiguration_h

#ifdef DEBUG
#define API_ENVIRONMENT_DEVELOPMENT
//#define API_ENVIRONMENT_TESTING
#define API_DEBUG // control of api response print
//#define LOCAL_DEBUG
#define ENVIRONMENT_DEVELOPMENT
#define ENVIRONMENT_DEVELOPMENT_NOANALYTICS
#endif

#define ENCRYPT_REQUEST

#endif

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#ifdef DEBUG
#define DLog(format, ...) NSLog((@"[LINE: %d]%s: " format), __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__)
#else
#define DLog(format, ...)
#endif
