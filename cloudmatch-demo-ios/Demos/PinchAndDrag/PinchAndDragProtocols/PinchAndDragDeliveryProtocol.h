//
//  PinchAndDragDeliveryProtocol.h
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PinchAndDragDeliveryProtocol <NSObject>

-(void)onCointoss:(double)cointoss;
-(void)onShapeDragInitiatedOnOtherSide:(NSString*)shape;
-(void)onShapeDragStoppedOnOtherSide;
-(void)onShapeReceivedOnOtherSide:(NSString*)shape;

@end
