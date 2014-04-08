//
//  UIImage+WWFoundation.m
//  WWFoundationDemo
//
//  Created by William Wu on 4/8/14.
//  Copyright (c) 2014 WW. All rights reserved.
//

#import "UIImage+WWFoundation.h"

@implementation UIImage (WWFoundation)

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                targetWidth,
                                                targetHeight,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                4 * targetWidth, CGImageGetColorSpace(self.CGImage),
                                                (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), self.CGImage);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    newImage = [UIImage imageWithCGImage:ref];
    
    if(newImage == nil) NSLog(@"could not scale image");
    CGContextRelease(bitmap);
    
    return newImage ;
}

- (UIImage*)rotateInRadians:(CGFloat)radians
{
    CGImageRef cgImage = self.CGImage;
    const CGFloat originalWidth = CGImageGetWidth(cgImage);
    const CGFloat originalHeight = CGImageGetHeight(cgImage);
    
    const CGRect imgRect = (CGRect){.origin.x = 0.0f, .origin.y = 0.0f,
        .size.width = originalWidth, .size.height = originalHeight};
    const CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, CGAffineTransformMakeRotation(radians));
    
    CGContextRef bmContext = NYXImageCreateARGBBitmapContext(rotatedRect.size.width, rotatedRect.size.height, 0);
    if (!bmContext)
        return nil;
    
    CGContextSetShouldAntialias(bmContext, true);
    CGContextSetAllowsAntialiasing(bmContext, true);
    CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
    CGContextTranslateCTM(bmContext, +(rotatedRect.size.width * 0.5f), +(rotatedRect.size.height * 0.5f));
    CGContextRotateCTM(bmContext, radians);
    
    CGContextDrawImage(bmContext, (CGRect){.origin.x = -originalWidth * 0.5f,  .origin.y = -originalHeight * 0.5f,
        .size.width = originalWidth, .size.height = originalHeight}, cgImage);
    
    CGImageRef rotatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage* rotated = [UIImage imageWithCGImage:rotatedImageRef];
    
    CGImageRelease(rotatedImageRef);
    CGContextRelease(bmContext);
    
    return rotated;
}

@end
