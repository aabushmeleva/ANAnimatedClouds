//
//  ANAnimatedView.m
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 26.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import "ANAnimatedView.h"

// paintCode
#import "ANCloudKit.h"

@interface ANAnimatedView ()

@property (strong, nonatomic) UIImageView *sunImageView;
@property (strong, nonatomic) NSArray *cloudViews;

@property (strong, nonatomic) NSMutableArray *cloudsArray;
@property (assign, nonatomic) BOOL isAnimating;
@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSInteger lastCloudIndex;

@end

@implementation ANAnimatedView

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
    self.isAnimating = NO;
    self.backgroundColor = [UIColor clearColor];

    [self createSun];
}

#pragma mark - Sun Creation

- (void)createSun {
    
    UIImageView *sunImageView = [[UIImageView alloc] initWithImage:ANCloudKit.imageOfSunIcon];
    
    [sunImageView setContentMode:UIViewContentModeScaleAspectFit];
    sunImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.sunImageView = sunImageView;
    
    [self addSubview: self.sunImageView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-self.layer.frame.size.width/9]];
}

#pragma mark - Sun Rotation

- (void)startSunRotation {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.beginTime = 0.0;
    rotation.duration = 6;
    rotation.fromValue = @(0.0);
    rotation.toValue = [NSNumber numberWithFloat:(2.0 * M_PI)];
    rotation.fillMode = kCAFillModeForwards;
    rotation.repeatCount = HUGE_VALF;
    rotation.removedOnCompletion = NO;
    
    [self.sunImageView.layer addAnimation:rotation forKey:@"transform.rotation"];
}

- (void)stopSunRotation {
    [self.sunImageView.layer removeAnimationForKey:@"transform.rotation"];
}

#pragma mark - Animation

- (void)startAnimation {
    if (self.isAnimating) return;
    
    self.isAnimating = YES;
    
    [self startSunRotation];
    [self createCloud];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(createCloud) userInfo:nil repeats:YES];
    
}
- (void)stopAnimation {
    if (!self.isAnimating) return;
    
    self.isAnimating = NO;
    
    [self stopSunRotation];
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.layer removeAllAnimations];
}

#pragma mark - Cloud  Creation

- (void)createCloud {
    UIImage *cloudImage;
    CGFloat topConstraintValue;
    NSTimeInterval duration;
    
    NSInteger randomNumber = [self rundomNumber];
    
    // soft prevention of repeat number
    if (randomNumber == self.lastCloudIndex) {
        randomNumber = [self rundomNumber];
    }
    
    self.lastCloudIndex = randomNumber;
    
    if (randomNumber == 1) {
        cloudImage = ANCloudKit.imageOfSmallCloudIcon;
        topConstraintValue = 78.0;
        duration = 10.0;
        
    } else if (randomNumber == 2) {
        cloudImage = ANCloudKit.imageOfMiddleCloudIcon;
        topConstraintValue = 45.0;
        duration = 14.0;
    } else {
        cloudImage = ANCloudKit.imageOfLargeCloudIcon;
        topConstraintValue = 35.0;
        duration = 30.0;
    }
    
    // imageView
    UIImageView *cloud = [[UIImageView alloc] initWithImage:cloudImage];
    
    [cloud setContentMode:UIViewContentModeScaleAspectFit];
    cloud.translatesAutoresizingMaskIntoConstraints = NO;

    [self.cloudsArray addObject:cloud];
    
    [self addSubview: cloud];
    
    // constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.sunImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cloud attribute:NSLayoutAttributeTop multiplier:1 constant:-topConstraintValue]];
    
    NSLayoutConstraint * horizontalConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cloud attribute:NSLayoutAttributeLeading multiplier:1 constant:cloud.frame.size.width];
    
    [self addConstraint:horizontalConstraint];
    
    [self layoutIfNeeded];
    
    // animation
    CGFloat constraintValue = - (self.layer.frame.size.width);
    horizontalConstraint.constant = constraintValue;
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self.cloudsArray removeObject:cloud];
        [cloud removeFromSuperview];
    }];
}

- (NSInteger)rundomNumber {
    return (int)1 + arc4random() % (3);
}

@end
