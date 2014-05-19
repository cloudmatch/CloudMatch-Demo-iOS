//
//  PinchAndViewDeliveryHelper.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 5/05/2014.
//  Copyright (c) 2014 CloudMatch. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const IMAGE_HEIGHT;

@interface PinchAndViewDeliveryHelper : NSObject

+(void)sendImageHeight:(NSInteger)imageHeight ToGroup:(NSString*)groupId;

@end
