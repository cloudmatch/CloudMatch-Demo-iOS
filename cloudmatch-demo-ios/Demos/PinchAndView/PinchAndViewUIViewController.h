//
//  PinchAndViewUIViewController.h
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMatchSDK/CloudMatchSDK.h>
#import "MyRectView.h"

@interface PinchAndViewUIViewController : UIViewController <CMOnMovementDelegate, CMOnServerEventDelegate>
{
    UIImageView *imageView;
    NSInteger mMyDeviceId;
    NSInteger mOtherDeviceId;
    UIButton *button1;
    UIImage* mImgObj;
    
    CGSize mViewDimensions;
    NSInteger mHalfScreenY;
    NSInteger mHalfScreenX;
    NSInteger mPointEndY;
    NSInteger mPointEndX;
    NSInteger mIVWidth;
    NSInteger mIVHeigth;
    NSInteger mIVTopX;
    NSInteger mIVTopY;
}

@property (nonatomic, strong) MyRectView* mMyRectView;

@end
