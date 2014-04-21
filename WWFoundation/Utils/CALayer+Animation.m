//
//  CALayer+Animation.m
//  gogoanime
//
//  Created by William Wu on 4/18/14.
//  Copyright (c) 2014 Shanghai ChuangYi Animation Technology Co., Ltd. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (CAAnimation)

- (void)pauseCAAnimation
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)resumeCAAnimation
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end
