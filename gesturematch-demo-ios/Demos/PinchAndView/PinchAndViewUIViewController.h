//
//  PinchAndViewUIViewController.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GestureMatchSDK/GestureMatchSDK.h>
#import "MyRectView.h"

@interface PinchAndViewUIViewController : UIViewController <GMOnMovementDelegate, GMOnServerEventDelegate>
{
    UIImageView *imageView;
    NSInteger mMyDeviceId;
    NSInteger mOtherDeviceId;
    UIButton *button1;
}

@property (nonatomic, strong) MyRectView* mMyRectView;

@end
