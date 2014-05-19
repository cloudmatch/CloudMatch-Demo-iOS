//
//  PinchAndDragDeliveryHelper.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinchAndDragDeliveryHelper : NSObject

-(void)sendShapeDragStart:(NSString*)shape ToGroup:(NSString*)groupId;
-(void)sendShapeReceivedAck:(NSString*)shape ToGroup:(NSString*)groupId;
-(void)sendShapeDragStopped:(NSString*)groupId;
-(void)sendCointoss:(double)cointoss ToGroup:(NSString*)groupId;

@end
