/*
 * Copyright 2014 cloudmatch.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

@class GMMatchee;
@class CMMatchResponse;
@class CMLeaveGroupResponse;
@class CMDisconnectResponse;
@class CMDeliveryResponse;
@class CMMatcheeDelivery;
@class CMMatcheeDeliveryMessage;
@class CMMatcheeLeftMessage;


@protocol CMOnServerEventDelegate <NSObject>
- (void)onMatchResponse:(CMMatchResponse*)response;
- (void)onLeaveGroupResponse:(CMLeaveGroupResponse*)response;
- (void)onDeliveryResponse:(CMDeliveryResponse*)response;
- (void)onMatcheeLeftMessage:(CMMatcheeLeftMessage*)message;
- (void)onMatcheeDelivery:(CMMatcheeDelivery*)delivery;
- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId;
- (void)onConnectionOpen;
- (void)onConnectionClosedWithWSReason:(NSString*)WSreason;
- (void)onConnectionError:(NSError*)error;
@end