//
//  ANAnimatedView.h
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 26.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANAnimatedView : UIView

- (void)updateViewAfterLoad;

- (void)startAnimation;
- (void)stopAnimation;

@end
