//
//  PinchAndDragMatchedProtocol.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PinchAndDragMatchedProtocol <NSObject>

-(void)onMatchedInGroup:(NSString*)groupId;
-(void)onMatcheeLeft;

@end
