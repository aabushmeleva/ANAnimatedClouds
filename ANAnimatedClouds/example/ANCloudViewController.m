//
//  ANCloudViewController.m
//  ANAnimatedClouds
//
//  Created by Anna Bushmeleva on 26.12.16.
//  Copyright © 2016 Your live. All rights reserved.
//

#import "ANCloudViewController.h"

// view
#import "ANAnimatedView.h"

@interface ANCloudViewController ()

@property (weak, nonatomic) IBOutlet ANAnimatedView *animatedView;

- (IBAction)startAnimateClouds:(id)sender;
- (IBAction)stopAnimateClouds:(id)sender;
@end

@implementation ANCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startAnimateClouds:(id)sender {
    if (self.isViewLoaded) {
        [self.animatedView startAnimation];
    }
}

- (IBAction)stopAnimateClouds:(id)sender {
     [self.animatedView stopAnimation];
}
@end
