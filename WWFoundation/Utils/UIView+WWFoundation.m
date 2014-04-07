//
//  UIView+WWFoundation.m
//  WWFoundation
//
//  Created by William Wu on 4/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "UIView+WWFoundation.h"

@implementation UIView (WWFoundation)

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:ctx];
    
    UIImage *anImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return anImage;
}

- (void)cleanupGestures
{
    for (UIGestureRecognizer *recognizer in self.gestureRecognizers)
    {
        [self removeGestureRecognizer:recognizer];
    }
}

@end

@implementation UIView (Geometry)

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)sizeW
{
    return self.frame.size.width;
}

- (void)setSizeW:(CGFloat)sizeW
{
    CGRect frame = self.frame;
    frame.size.width = sizeW;
    self.frame = frame;
}

- (CGFloat)sizeH
{
    return self.frame.size.height;
}

- (void)setSizeH:(CGFloat)sizeH
{
    CGRect frame = self.frame;
    frame.size.height = sizeH;
    self.frame = frame;
}

@end

@implementation UIView (NibLoading)

+ (instancetype)loadInstanceFromNib
{
    UIView *view = [[[self class] alloc] init];
    
    [view awakeFromNib];
    
    return view;
}

@end
