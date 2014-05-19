//
//  PinchAndDragServerEventDelegate.m
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "PinchAndDragServerEventDelegate.h"
#import "PinchAndDragConsts.h"

@implementation PinchAndDragServerEventDelegate

-(void)setDeliveryDelegate:(id<PinchAndDragDeliveryProtocol>)deliveryDelegate
{
    mDeliveryDelegate = deliveryDelegate;
}

-(void)setMatchedDelegate:(id<PinchAndDragMatchedProtocol>)matchedDelegate
{
    mMatchedDelegate = matchedDelegate;
}

# pragma mark - onServerEventDelegate

- (void)onMatchResponse:(CMMatchResponse*)response
{
    NSLog(@"Pinch & Drag, onMatchResponse");
    switch (response.mOutcome) {
        case OutcomeOk:
            NSLog(@"Matched in a group of %ld%@", (long)response.mGroupSize, @".");
            if (mMatchedDelegate != nil) {
                [mMatchedDelegate onMatchedInGroup:response.mGroupId];
            }
            break;
        case OutcomeFail:
            switch (response.mResponseReason) {
                case MatchReasonTimeout:
                    NSLog(@"Match request timed out.");
                    // TODO: show information to user
                    break;
                case MatchReasonUncertain:
                    break;
                case MatchReasonInvalidRequest:
                    break;
                case MatchReasonError:
                case MatchReasonUnknown:
                default:
                    break;
            }
        default:
            // error!
            break;
    }
}

- (void)onLeaveGroupResponse:(CMLeaveGroupResponse*)response
{

}

- (void)onDeliveryResponse:(CMDeliveryResponse*)response
{

}

- (void)onMatcheeLeftMessage:(CMMatcheeLeftMessage*)message
{

}

- (void)onMatcheeDelivery:(CMMatcheeDelivery*)delivery
{
    NSLog(@"Pinch & Drag, matchee delivery, payload: %@", delivery.mPayload);

    NSData *jsonData = [delivery.mPayload dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    if ([jsonDict objectForKey:COIN_TOSS] != nil) {
        NSNumber *temp = [jsonDict objectForKey:COIN_TOSS];
        [mDeliveryDelegate onCointoss:[temp doubleValue]];
    } else if ([jsonDict objectForKey:SHAPE_DRAG] != nil) {
        NSString *shape = [jsonDict objectForKey:SHAPE_DRAG];
        [mDeliveryDelegate onShapeDragInitiatedOnOtherSide:shape];
    } else if ([jsonDict objectForKey:SHAPE_ACQUISITION_ACK] != nil) {
        NSString* shape = [jsonDict objectForKey:SHAPE_ACQUISITION_ACK];
        [mDeliveryDelegate onShapeReceivedOnOtherSide:shape];
    } else if ([jsonDict objectForKey:SHAPE_DRAG_STOPPED] != nil) {
        [mDeliveryDelegate onShapeDragStoppedOnOtherSide];
    }
}

- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId
{

}

- (void)onConnectionOpen
{
    NSLog(@"Pinch & Drag, onConnectionOpen");
}

- (void)onConnectionClosedWithWSReason:(NSString*)WSreason
{

}

- (void)onConnectionError:(NSError*)error
{
    NSLog(@"Pinch & Drag, onConnectionError: %@", error.description);
}

@end
