//
//  ANSunView.m
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 27.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import "ANSunView.h"

// paintCode
#import "ANCloudKit.h"

@implementation ANSunView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    UIImageView *sunImageView = [[UIImageView alloc] initWithImage:ANCloudKit.imageOfSunIcon];
    
    sunImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview: sunImageView];
    


}

#pragma mark - Rotation

- (void)startAnimating {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.beginTime = 0.0;
    rotation.duration = 6;
    rotation.fromValue = @(0.0);
    rotation.toValue = [NSNumber numberWithFloat:(2.0 * M_PI)];
    rotation.fillMode = kCAFillModeForwards;
    rotation.repeatCount = HUGE_VALF;
    rotation.removedOnCompletion = NO;
    
    [self.layer addAnimation:rotation forKey:@"transform.rotation"];
}

- (void)stopAnimating {
    [self.layer removeAnimationForKey:@"transform.rotation"];
}

@end
