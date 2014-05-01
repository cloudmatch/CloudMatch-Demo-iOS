//
//  PinchAndDragMatchedProtocol.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PinchAndDragMatchedProtocol <NSObject>

-(void)onMatchedInGroup:(NSString*)groupId;

@end
