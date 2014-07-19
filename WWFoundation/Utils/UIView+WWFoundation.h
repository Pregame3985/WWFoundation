//
//  UIView+WWFoundation.h
//  WWFoundation
//
//  Created by William Wu on 4/7/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WWFoundation)

- (UIImage *)screenshot;

- (void)cleanupGestures;

- (void)fillLayer:(CAShapeLayer *)shapeLayer
        withColor:(UIColor *)color
           atPath:(UIBezierPath *)path;

@end

@interface UIView (Geometry)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat sizeW;
@property (nonatomic, assign) CGFloat sizeH;

@end

@interface UIView (NibLoading)

+ (instancetype)loadInstanceFromNib;

@end
