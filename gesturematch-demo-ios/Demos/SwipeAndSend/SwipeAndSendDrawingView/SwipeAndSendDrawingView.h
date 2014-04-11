//
//  DrawingView.h
//  DrawLinesInnerOuter
//
//  Created by Fabio Tiriticco on 30/10/12.
//  Copyright (c) 2012 Fabio Tiriticco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GestureMatchSDK/GestureMatchSDK.h>

@interface SwipeAndSendDrawingView : UIView <GMOnMovementDelegate> {
    UIBezierPath *myPath;
}

-(void)clearScreen;

@end
