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
#define API_ENVIRONMENT_TESTING
#define API_DEBUG // control of api response print
//#define LOCAL_DEBUG
#define ENVIRONMENT_DEVELOPMENT
#define ENVIRONMENT_DEVELOPMENT_NOANALYTICS
#endif

#ifdef API_ENVIRONMENT_DEVELOPMENT
#define DOMAIN_HOST     @"http://api.rippling.com"
#define IAP_URL         @"https://sandbox.itunes.apple.com/verifyReceipt"
#else
#define DOMAIN_HOST     @"http://api.rippling.com"
#define IAP_URL         @"https://buy.itunes.apple.com/verifyReceipt"
#endif

#define PPT_DETAIL_FILE_PATH        @"ppts/"
#define DOC_DETAIL_FILE_PATH        @"docs/"
#define THUMBNAIL_PATH              @"thumbnail/"
#define MEDIA_DETAIL_FILE_PATH      @"medias/"

#define CONF_IMAGE_SAVE_PATH        @"conf/"

#define WEBDAV_USERNAME             @"test"
#define WEBDAV_PASSWORD             @"1qaz2wsx"

#endif

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
