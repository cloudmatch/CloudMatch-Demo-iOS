//
//  SwipeAndColorDemoViewController.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeAndColorDrawingView.h"
#import "SwipeAndColorMatchedProtocol.h"

@class SwipeAndColorServerEventDelegate;

@interface SwipeAndColorViewController : UIViewController <SwipeAndColorMatchedProtocol>
{
    NSString* mGroupId;
    NSInteger mGroupSize;
    NSArray* mColorTable;
    NSInteger mCurrentColorIndex;
    UIButton *mChangeColorButton;
    SwipeAndColorDrawingView *drawingView;
    SwipeAndColorServerEventDelegate* serverEventDelegate;
}

-(void)onMatchedInGroup:(NSString*)groupId Size:(NSInteger)size MyId:(NSInteger)myId;
@property (weak, nonatomic) IBOutlet UIImageView *mPinchIcon;

@end
