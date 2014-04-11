//
//  PinchAndDragDeliveryHelper.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import "PinchAndDragDeliveryHelper.h"
#import "PinchAndDragConsts.h"
#import <GestureMatchSDK/GestureMatchSDK.h>

@implementation PinchAndDragDeliveryHelper

-(void)sendShapeDragStart:(NSString*)shape ToGroup:(NSString*)groupId
{
    // prepare JSON and deliver it
    NSString* toSend = [PinchAndDragDeliveryHelper getJSONStringFromKey:SHAPE_DRAG AndObject:shape];
    [[GMGestureMatchClient sharedInstance] deliverPayload:toSend toGroup:groupId];
}

-(void)sendShapeReceivedAck:(NSString*)shape ToGroup:(NSString*)groupId
{
    // prepare JSON and deliver it
    NSString* toSend = [PinchAndDragDeliveryHelper getJSONStringFromKey:SHAPE_ACQUISITION_ACK AndObject:shape];
    [[GMGestureMatchClient sharedInstance] deliverPayload:toSend toGroup:groupId];
}

-(void)sendShapeDragStopped:(NSString*)groupId
{
    // prepare JSON and deliver it
    NSString* toSend = [PinchAndDragDeliveryHelper getJSONStringFromKey:SHAPE_DRAG_STOPPED AndObject:@"0"];
    [[GMGestureMatchClient sharedInstance] deliverPayload:toSend toGroup:groupId];
}

-(void)sendCointoss:(double)cointoss ToGroup:(NSString*)groupId
{
    // prepare JSON and deliver it
    NSNumber* cointossNumber = [[NSNumber alloc] initWithDouble:cointoss];
    NSString* toSend = [PinchAndDragDeliveryHelper getJSONStringFromKey:COIN_TOSS AndObject:cointossNumber];
    [[GMGestureMatchClient sharedInstance] deliverPayload:toSend toGroup:groupId];
}

+(NSString*)getJSONStringFromKey:(NSString*)key AndObject:(NSObject*)value
{
    // prepare JSON and deliver it
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:value forKey:key];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
