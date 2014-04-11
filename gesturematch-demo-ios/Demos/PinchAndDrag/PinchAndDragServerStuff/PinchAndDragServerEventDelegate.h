//
//  PinchAndDragServerEventDelegate.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GestureMatchSDK/GestureMatchSDK.h>
#import "PinchAndDragMatchedProtocol.h"
#import "PinchAndDragDeliveryProtocol.h"

@interface PinchAndDragServerEventDelegate : NSObject <GMOnServerEventDelegate>
{
    id<PinchAndDragDeliveryProtocol> mDeliveryDelegate;
    id<PinchAndDragMatchedProtocol> mMatchedDelegate;
}

-(void)setDeliveryDelegate:(id<PinchAndDragDeliveryProtocol>)deliveryDelegate;
-(void)setMatchedDelegate:(id<PinchAndDragMatchedProtocol>)matchedDelegate;

@end

