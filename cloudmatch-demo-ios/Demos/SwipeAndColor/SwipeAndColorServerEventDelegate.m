//
//  SwipeAndColorServerEventDelegate.m
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "SwipeAndColorServerEventDelegate.h"

@implementation SwipeAndColorServerEventDelegate

-(void)setOnMatchedDelegate:(id<SwipeAndColorMatchedProtocol>)delegate
{
    mMatchedDelegate = delegate;
}

# pragma mark - onServerEventDelegate

- (void)onMatchResponse:(CMMatchResponse*)response
{
    NSLog(@"Swipe & Color, onMatchResponse");
    switch (response.mOutcome) {
        case OutcomeOk:
            if (mMatchedDelegate != nil) {
                [mMatchedDelegate onMatchedInGroup:response.mGroupId Size:response.mGroupSize MyId:response.mMyIdInGroup];
            }
            NSLog(@"Matched in a group of %ld%@", (long)response.mGroupSize, @".");
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

- (void)onDisconnectResponse:(CMDisconnectResponse*)response
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
    NSLog(@"matchee delivery, payload: %@", delivery.mPayload);
    [mMatchedDelegate onDelivery:delivery.mPayload];
}

- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId
{

}

- (void)onConnectionOpen
{
    NSLog(@"Swipe & Color, onConnectionOpen");
}

- (void)onConnectionClosedWithWSReason:(NSString*)WSreason
{

}

- (void)onConnectionError:(NSError*)error
{
    NSLog(@"Swipe & Color, onConnectionError: %@", error.description);
}

@end
