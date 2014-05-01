//
//  PinchAndViewUIViewController.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import "PinchAndViewUIViewController.h"

@implementation PinchAndViewUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // additional setup here
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"PinchAndView Demo starting");
    
    [[CMCloudMatchClient sharedInstance] attachToView:self.view withMovementDelegate:self criteria:kCMCriteriaPinch];
    [[CMCloudMatchClient sharedInstance] setServerEventDelegate:self];
    [[CMCloudMatchClient sharedInstance] connect];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc.");
    [[CMCloudMatchClient sharedInstance] detachFromView:self.view];
}

-(void)dismissViews:(id)sender {
    NSLog(@"works");
    if (imageView != nil) {
        NSLog(@"removing drawingView");
        [imageView removeFromSuperview];
        imageView = nil;
    }
    if (button1 != nil) {
        NSLog(@"removing button");
        [button1 removeFromSuperview];
        button1 = nil;
    }
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

-(void)removeTinyRect:(NSValue*)ignore
{
    [self.mMyRectView removeFromSuperview];
}

#pragma mark - onMovementDelegate

-(void)onMovementDetection:(Movement)movement swipeType:(SwipeType)swipeType pointStart:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd
{
    // cancel previous stuff
    [self.mMyRectView removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeTinyRect:) object:nil];
    
    NSInteger size = 20;
    CGFloat rectX = pointEnd.x;
    switch (movement) {
        case kMovementInnerRight:
            rectX = rectX - size;
            break;
            
        default:
            break;
    }
    
    NSLog(@"onMovementDetection: (%f, %f) to (%f, %f)", pointStart.x, pointStart.y, pointEnd.x, pointEnd.y);
    CGRect rect = CGRectMake(rectX, pointEnd.y, size, size);
    self.mMyRectView = [[MyRectView alloc] initWithFrame:rect];
    [self.view addSubview:self.mMyRectView];
    
    // remove it after a bit
    [self performSelector:@selector(removeTinyRect:) withObject:nil afterDelay:3.0];

}

- (BOOL)isSwipeValid
{
    // always valid in this demo
    return YES;
}

- (NSString *)getEqualityParam
{
    return nil;
}


# pragma mark - onServerEventDelegate

- (void)onMatchResponse:(CMMatchResponse*)response
{
    switch (response.mOutcome) {
        case OutcomeOk:
        {
            NSInteger otherDeviceId = -1;
            for (NSInteger i = 0; i < [response.mDevicesInGroup count]; i++) {
                if (i != response.mMyIdInGroup) {
                    otherDeviceId = i;
                    break;
                }
            }
            
            CMDeviceInScheme* myself = [response.mPositionScheme getDeviceForId:response.mMyIdInGroup];
            CMDeviceInScheme* other = [response.mPositionScheme getDeviceForId:otherDeviceId];
            
            if (myself != nil && other != nil) {
                BOOL xGreater = myself.mPosition.x > other.mPosition.x;
                UIImage *imgObj = nil;
                if (xGreater) {
                    // i'm right
                    NSLog(@"matched in a group of %ld, I'm right", (long)response.mGroupSize);
                    imgObj = [UIImage imageNamed:@"split_image_2_1.png"];
                } else {
                    NSLog(@"matched in a group of %ld, I'm left", (long)response.mGroupSize);
                    imgObj = [UIImage imageNamed:@"split_image_2_2.png"];
                }
                
                if (imgObj != nil) {
                    // the frame here below should adapt to the device that this app is running on
                    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                    [imageView setContentMode:UIViewContentModeScaleToFill];
                    [imageView setImage:imgObj];
                    [self.view addSubview:imageView];
                    
                    if (button1 == nil) {
                        button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                        [button1 addTarget:self action:@selector(dismissViews:) forControlEvents:UIControlEventTouchDown];
                        [self.view addSubview:button1];
                    }
                }
            }
        }
            break;
            
        case OutcomeFail:
            switch (response.mResponseReason) {
                case MatchReasonTimeout:
                    NSLog(@"match request timeout");
                    break;
                    
                default:
                    NSLog(@"match failed");
                    break;
            }
        default:
            
            break;
    }
    
    
}

- (void)onLeaveGroupResponse:(CMLeaveGroupResponse*)response
{
    
}

- (void)onDisconnectResponse:(CMDisconnectResponse*)response
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
    
}

- (void)onMatcheeDeliveryProgress:(NSInteger)progress forDeliveryId:(NSString*)deliveryId
{
    
}

- (void)onConnectionOpen
{
    NSLog(@"onConnectionOpen");
}

- (void)onConnectionClosedWithWSReason:(NSString*)WSreason
{
    
}

- (void)onConnectionError:(NSError*)error
{
    NSLog(@"onConnectionError: %@", error.description);
}

@end
