//
//  PinchAndDragShapesView.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMatchSDK/CloudMatchSDK.h>
#import "PinchAndDragDeliveryProtocol.h"
#import "PinchAndDragMatchedProtocol.h"
#import "PinchAndDragDeliveryHelper.h"
#import "CircleView.h"
#import "SquareView.h"
#import "TinyCircleView.h"

@interface PinchAndDragShapesView : UIView <CMOnMovementDelegate, PinchAndDragDeliveryProtocol, PinchAndDragMatchedProtocol>
{
    double mMyCointossValue;
    PinchAndDragDeliveryHelper* mDeliveryHelper;
    CGPoint mCircleInitialPosition;
    CGPoint mSquareInitialPosition;
}

@property (nonatomic, strong) NSString *mGroupId;
@property (nonatomic, strong) CircleView *mCircleView;
@property (nonatomic, strong) SquareView *mSquareView;
@property (nonatomic, strong) TinyCircleView *mTinyCircleView;
@property (nonatomic, strong) UIView *mMovingView;
@property (nonatomic, strong) NSString *mMovingShape;
@property (nonatomic, strong) NSString *mShapeBeingDraggedOnOtherSide;

@end
