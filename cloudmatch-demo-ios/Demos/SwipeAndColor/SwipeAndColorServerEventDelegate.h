//
//  SwipeAndColorServerEventDelegate.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudMatchSDK/CloudMatchSDK.h>
#import "SwipeAndColorMatchedProtocol.h"

@interface SwipeAndColorServerEventDelegate : NSObject <CMOnServerEventDelegate>
{
    id<SwipeAndColorMatchedProtocol> mMatchedDelegate;
}

-(void)setOnMatchedDelegate:(id<SwipeAndColorMatchedProtocol>)delegate;

@end
