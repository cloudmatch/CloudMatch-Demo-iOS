//
//  SwipeAndColorMatchedProtocol.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SwipeAndColorMatchedProtocol <NSObject>

@required

- (void)onMatchedInGroup:(NSString*)groupId Size:(NSInteger)size MyId:(NSInteger)myId;
- (void)onMatheeLeft;
- (void)onDelivery:(NSString*)payload;

@end