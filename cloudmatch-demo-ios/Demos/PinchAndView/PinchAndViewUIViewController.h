//
//  PinchAndViewUIViewController.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMatchSDK/CloudMatchSDK.h>
#import "MyRectView.h"

@interface PinchAndViewUIViewController : UIViewController <CMOnMovementDelegate, CMOnServerEventDelegate>

@property (nonatomic, strong) MyRectView* mMyRectView;

@end
