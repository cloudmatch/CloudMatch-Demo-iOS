//
//  PinchAndDragServerEventDelegate.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudMatchSDK/CloudMatchSDK.h>
#import "PinchAndDragMatchedProtocol.h"
#import "PinchAndDragDeliveryProtocol.h"

@interface PinchAndDragServerEventDelegate : NSObject <CMOnServerEventDelegate>
{
    id<PinchAndDragDeliveryProtocol> mDeliveryDelegate;
    id<PinchAndDragMatchedProtocol> mMatchedDelegate;
}

-(void)setDeliveryDelegate:(id<PinchAndDragDeliveryProtocol>)deliveryDelegate;
-(void)setMatchedDelegate:(id<PinchAndDragMatchedProtocol>)matchedDelegate;

@end

