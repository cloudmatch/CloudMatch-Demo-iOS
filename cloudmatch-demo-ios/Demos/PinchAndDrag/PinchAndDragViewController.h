//
//  PinchAndDragViewController.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinchAndDragShapesView.h"
@class PinchAndDragServerEventDelegate;

@interface PinchAndDragViewController : UIViewController
{
    PinchAndDragServerEventDelegate* mServerEventDelegate;
    PinchAndDragShapesView* mShapesView;
}
@end
