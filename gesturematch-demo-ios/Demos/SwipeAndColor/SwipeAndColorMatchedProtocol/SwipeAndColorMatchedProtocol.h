//
//  SwipeAndColorMatchedProtocol.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SwipeAndColorMatchedProtocol <NSObject>

- (void)onMatchedInGroup:(NSString*)groupId Size:(NSInteger)size MyId:(NSInteger)myId;
- (void)onDelivery:(NSString*)payload;

@end