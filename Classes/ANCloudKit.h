//
//  ANCloudKit.h
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 30.12.16.
//  Copyright © 2016 (null). All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//

#import <UIKit/UIKit.h>



typedef enum : NSInteger
{
    ANCloudKitResizingBehaviorAspectFit, //!< The content is proportionally resized to fit into the target rectangle.
    ANCloudKitResizingBehaviorAspectFill, //!< The content is proportionally resized to completely fill the target rectangle.
    ANCloudKitResizingBehaviorStretch, //!< The content is stretched to match the entire target rectangle.
    ANCloudKitResizingBehaviorCenter, //!< The content is centered in the target rectangle, but it is NOT resized.

} ANCloudKitResizingBehavior;

extern CGRect ANCloudKitResizingBehaviorApply(ANCloudKitResizingBehavior behavior, CGRect rect, CGRect target);


@interface ANCloudKit : NSObject

// iOS Controls Customization Outlets
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* smallCloudIconTargets;
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* middleCloudIconTargets;
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* largeCloudIconTargets;
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* sunIconTargets;
@property (strong, nonatomic) IBOutletCollection(NSObject) NSArray* planeIconTargets;

// Drawing Methods
+ (void)drawSunIcon;
+ (void)drawSunIconWithFrame: (CGRect)targetFrame resizing: (ANCloudKitResizingBehavior)resizing;

// Generated Images
+ (UIImage*)imageOfSmallCloudIcon;
+ (UIImage*)imageOfMiddleCloudIcon;
+ (UIImage*)imageOfLargeCloudIcon;
+ (UIImage*)imageOfSunIcon;
+ (UIImage*)imageOfPlaneIcon;

@end
