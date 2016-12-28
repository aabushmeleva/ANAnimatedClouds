//
//  ANCloudImageView.h
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 27.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANCloudImageView : UIImageView

@property (strong, nonatomic) UIImage *cloudImage;
@property (assign, nonatomic) CGFloat topConstraintValue;
@property (assign, nonatomic) NSTimeInterval duration;

@end
