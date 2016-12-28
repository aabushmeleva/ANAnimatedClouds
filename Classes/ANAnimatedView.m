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

// view
#import "ANCloudImageView.h"
#import "ANSunView.h"

@interface ANAnimatedView ()

@property (strong, nonatomic) ANSunView *sunView;

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
    
    ANSunView *sun = [[ANSunView alloc] initWithFrame:CGRectMake(self.layer.frame.size.width*3/9+80, self.layer.frame.size.width/9+80, 79, 79)];
    self.sunView = sun;
    
    [self addSubview: self.sunView];
}

- (void)startAnimation {
    if (self.isAnimating) return;
    
    self.isAnimating = YES;
    
    [self.sunView startAnimating];
    [self createCloud];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(createCloud) userInfo:nil repeats:YES];
    
}
- (void)stopAnimation {
    if (!self.isAnimating) return;
    
    self.isAnimating = NO;
    
    [self.sunView stopAnimating];
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.layer removeAllAnimations];
}


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
        topConstraintValue = 72.0;
        duration = 10.0;
        
    } else if (randomNumber == 2) {
        cloudImage = ANCloudKit.imageOfMiddleCloudIcon;
        topConstraintValue = 46.0;
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.sunView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cloud attribute:NSLayoutAttributeTop multiplier:1 constant:-topConstraintValue]];
    
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

- (void)animateCloudConstraint:(NSLayoutConstraint *)constraint withCloud:(UIImageView *)cloud {
    CGFloat constraintValue = - (self.layer.frame.size.width);
    constraint.constant = constraintValue;
    
    [UIView animateWithDuration:8 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
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
