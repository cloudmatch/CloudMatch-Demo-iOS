//
//  SwipeAndSendUIViewController.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudMatchSDK/CloudMatchSDK.h>
#import "SwipeAndSendDrawingView.h"

@interface SwipeAndSendUIViewController : UIViewController <CMOnServerEventDelegate>
{
    NSString* mGroupId;
    SwipeAndSendDrawingView *drawingView;
}
@property (weak, nonatomic) IBOutlet UITextField *textToSend;
@property (weak, nonatomic) IBOutlet UILabel *receivedText;
@end
