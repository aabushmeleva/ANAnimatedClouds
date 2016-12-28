//
//  ANGradientView.m
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 26.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import "ANGradientView.h"

@implementation ANGradientView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.firstColor = [UIColor lightGrayColor];
    self.finishColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect {
    CGRect frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    [self drawProfileGradientImageWithFrame:frame];
}

- (void)drawProfileGradientImageWithFrame: (CGRect)frame
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Gradient Declarations
    CGFloat profileAvatarGradientLocations[] = {0, 1};
    CGGradientRef profileAvatarGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)self.firstColor.CGColor, (id)self.finishColor.CGColor], profileAvatarGradientLocations);
    
    //// Rectangle Drawing
    CGRect rectangleRect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, profileAvatarGradient,
                                CGPointMake(CGRectGetMidX(rectangleRect), CGRectGetMinY(rectangleRect)),
                                CGPointMake(CGRectGetMidX(rectangleRect), CGRectGetMaxY(rectangleRect)),
                                0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(profileAvatarGradient);
    CGColorSpaceRelease(colorSpace);
}
@end
