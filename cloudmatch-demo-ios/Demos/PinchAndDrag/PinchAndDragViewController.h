//
//  PinchAndDragViewController.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinchAndDragShapesView.h"
@class PinchAndDragServerEventDelegate;

@interface PinchAndDragViewController : UIViewController <PinchAndDragMatchedProtocol>
{
    PinchAndDragServerEventDelegate* mServerEventDelegate;
    PinchAndDragShapesView* mShapesView;
}
@property (weak, nonatomic) IBOutlet UIImageView *mPinchView;
@end
