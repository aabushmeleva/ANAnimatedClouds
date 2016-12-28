//
//  ANSunView.m
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 27.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import "ANSunView.h"

// paintCode
#import "CloudKit.h"

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
    
    UIImageView *cunImage = [[UIImageView alloc] initWithImage:CloudKit.imageOfSunIcon];
    [cunImage setContentMode:UIViewContentModeScaleAspectFit];
    
    [self addSubview: cunImage];
}

@end
