//
//  SwipeAndSendUIViewController.m
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "SwipeAndSendUIViewController.h"

@interface SwipeAndSendUIViewController ()

@end

@implementation SwipeAndSendUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"SwipeAndSend Demo starting");

    // the frame here below should adapt to the device that this app is running on
    drawingView = [[SwipeAndSendDrawingView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:drawingView];
    [self.view sendSubviewToBack:drawingView];

    mGroupId = @"";
    
    // TODO: if you want to build this, request a free pair of apiKey / appId on cloudmatch.io!
    NSString* myApiKey = @"DUMMY-API-KEY";
    NSString* myAppId = @"DUMMY-APP-ID";

    [[CMCloudMatchClient sharedInstance] attachToView:drawingView withMovementDelegate:drawingView criteria:kCMCriteriaSwipe];
    [[CMCloudMatchClient sharedInstance] setServerEventDelegate:self apiKey:myApiKey appId:myAppId];
    [[CMCloudMatchClient sharedInstance] connect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"SwipeAndSendUIViewController, memory warning");
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc.");
    [[CMCloudMatchClient sharedInstance] detachFromView:self.view];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



# pragma mark ui actions
- (IBAction)sendButtonAction:(id)sender {
    NSString *textToSend = [[NSString alloc] initWithString: self.textToSend.text];
    NSLog(@"going to send: %@ to group %@", textToSend, mGroupId);
    [[CMCloudMatchClient sharedInstance] deliverPayload:textToSend toGroup:mGroupId];
}

# pragma mark - onServerEventDelegate

- (void)onMatchResponse:(CMMatchResponse*)response
{
    NSLog(@"onMatchResponse");
    switch (response.mOutcome) {
        case OutcomeOk:
            mGroupId = response.mGroupId;
            NSLog(@"Matched in a group of %ld%@", (long)response.mGroupSize, @".");
            break;
        case OutcomeFail:
            switch (response.mResponseReason) {
                case MatchReasonTimeout:
                    NSLog(@"Match request timed out.");
                    // TODO: show information to user
                    break;
                case MatchReasonUncertain:
                    break;
                case MatchReasonInvalidRequest:
                    break;
                case MatchReasonError:
                case MatchReasonUnknown:
                default:
                    break;
            }
        default:
            // error!
            break;
    }
}

- (void)onLeaveGroupResponse:(CMLeaveGroupResponse*)response
{

}

- (void)onDeliveryResponse:(CMDeliveryResponse*)response
{

}

- (void)onMatcheeLeftMessage:(CMMatcheeLeftMessage*)message
{

}

- (void)onMatcheeDelivery:(CMMatcheeDelivery*)delivery
{
    self.receivedText.text = delivery.mPayload;
}

- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId
{

}

- (void)onConnectionOpen
{
    NSLog(@"Swipe & Send, onConnectionOpen");
}

- (void)onConnectionClosedWithWSReason:(NSString*)WSreason
{
    NSLog(@"Swipe & Send, onConnectionClosed, reason %@", WSreason);
}

- (void)onConnectionError:(NSError*)error
{
    NSLog(@"onConnectionError: %@", error.description);
}


@end
