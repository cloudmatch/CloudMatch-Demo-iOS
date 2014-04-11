//
//  SwipeAndSendUIViewController.h
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GestureMatchSDK/GestureMatchSDK.h>
#import "SwipeAndSendDrawingView.h"

@interface SwipeAndSendUIViewController : UIViewController <GMOnServerEventDelegate>
{
    NSString* mGroupId;
    SwipeAndSendDrawingView *drawingView;
}
@property (weak, nonatomic) IBOutlet UITextField *textToSend;
@property (weak, nonatomic) IBOutlet UILabel *receivedText;
@end
