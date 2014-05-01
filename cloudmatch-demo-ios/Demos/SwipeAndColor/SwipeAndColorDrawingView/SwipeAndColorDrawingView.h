//
//  DrawingView.h
//  DrawLinesInnerOuter
//
//  Created by Fabio Tiriticco on 30/10/12.
//  Copyright (c) 2012 Fabio Tiriticco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMatchSDK/CloudMatchSDK.h>

@interface SwipeAndColorDrawingView : UIView <CMOnMovementDelegate> {
    UIBezierPath *myPath;
}

-(void)clearScreen;

@end
