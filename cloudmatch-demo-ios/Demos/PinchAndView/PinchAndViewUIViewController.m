//
//  PinchAndViewUIViewController.m
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 15/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "PinchAndViewUIViewController.h"
#import "PinchAndViewDeliveryHelper.h"

@interface PinchAndViewUIViewController ()
{
    UIImageView* imageView;
    NSInteger mMyDeviceId;
    NSInteger mOtherDeviceId;
    UIButton* button1;
    UIImage* mImgObj;
    
    CGSize mViewDimensions;
    NSInteger mHalfScreenY;
    NSInteger mHalfScreenX;
    NSInteger mPointEndY;
    NSInteger mPointEndX;
    NSInteger mIVWidth;
    NSInteger mIVHeigth;
    NSInteger mIVTopX;
    NSInteger mIVTopY;
}
@end

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
    
    // TODO: if you want to build this, request a free pair of apiKey / appId on cloudmatch.io!
    NSString* myApiKey = @"DUMMY-API-KEY";
    NSString* myAppId = @"DUMMY-APP-ID";
    
    mViewDimensions = self.view.bounds.size;
    mHalfScreenX = mViewDimensions.width / 2;
    mHalfScreenY = mViewDimensions.height / 2;
    
    [[CMCloudMatchClient sharedInstance] attachToView:self.view withMovementDelegate:self criteria:kCMCriteriaPinch];
    [[CMCloudMatchClient sharedInstance] setServerEventDelegate:self apiKey:myApiKey appId:myAppId];
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
    if (imageView != nil) {
        [imageView removeFromSuperview];
        imageView = nil;
    }
    if (button1 != nil) {
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

-(void)displayImage
{
    
    if (mImgObj != nil) {
        // the frame here below should adapt to the device that this app is running on
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(mIVTopX, mIVTopY, mIVWidth, mIVHeigth)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:mImgObj];
        [self.view insertSubview:imageView atIndex:0];
        
        if (button1 == nil) {
            button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, mViewDimensions.width, mViewDimensions.height)];
            [button1 addTarget:self action:@selector(dismissViews:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:button1];
        }
    }
}

#pragma mark - onMovementDelegate

-(void)onMovementDetection:(Movement)movement swipeType:(SwipeType)swipeType pointStart:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd
{
    NSLog(@"onMovementDetection: (%f, %f) to (%f, %f)", pointStart.x, pointStart.y, pointEnd.x, pointEnd.y);
    
    mPointEndX = pointEnd.x;
    mPointEndY = pointEnd.y;
    
    // this block takes care of the little shape to show
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
        

        CGRect rect = CGRectMake(rectX, pointEnd.y, size, size);
        self.mMyRectView = [[MyRectView alloc] initWithFrame:rect];
        [self.view addSubview:self.mMyRectView];
        
        // remove it after a bit
        [self performSelector:@selector(removeTinyRect:) withObject:nil afterDelay:3.0];
    }
    
    // this block takes care of the screen position calculations
    {
        if (mPointEndY > mHalfScreenY) {
            mIVHeigth = (mViewDimensions.height - mPointEndY) * 2;
            mIVTopY = mViewDimensions.height - mIVHeigth;
        } else {
            mIVHeigth = mPointEndY * 2;
            mIVTopY = 0;
        }
        
        mIVWidth = mIVHeigth * mViewDimensions.width / mViewDimensions.height;
        if (mPointEndX > mHalfScreenX) {
            mIVTopX = mViewDimensions.width - mIVWidth;
        } else {
            mIVTopX = 0;
        }
        
        NSLog(@"iv height: %ld, width: %ld, y: %ld, x: %ld", (long)mIVHeigth, (long)mIVWidth, (long)mIVTopY, (long)mIVTopX);
    }
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
                mImgObj = nil;
                if (xGreater) {
                    // i'm right
                    NSLog(@"matched in a group of %ld, I'm right", (long)response.mGroupSize);
                    mImgObj = [UIImage imageNamed:@"split_image_2_1.png"];
                } else {
                    NSLog(@"matched in a group of %ld, I'm left", (long)response.mGroupSize);
                    mImgObj = [UIImage imageNamed:@"split_image_2_2.png"];
                }
                
                [PinchAndViewDeliveryHelper sendImageHeight:mIVHeigth  ToGroup:response.mGroupId];
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

- (void)onDeliveryResponse:(CMDeliveryResponse*)response
{
    
}

- (void)onMatcheeLeftMessage:(CMMatcheeLeftMessage*)message
{
    
}

- (void)onMatcheeDelivery:(CMMatcheeDelivery*)delivery
{
    NSLog(@"Pinch & Drag, matchee delivery, payload: %@", delivery.mPayload);
    
    NSData *jsonData = [delivery.mPayload dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    if ([jsonDict objectForKey:IMAGE_HEIGHT] != nil) {
        NSNumber *othersImageHeight = [jsonDict objectForKey:IMAGE_HEIGHT];
        
        // do I need to resize or reposition my image calculations?
        if ([othersImageHeight integerValue] > mIVHeigth) {
            // display it as it is
            [self displayImage];
        } else {
            // recalculate positions and dimensions
            {
                mIVHeigth = [othersImageHeight integerValue];
                mIVWidth = mIVHeigth * mViewDimensions.width / mViewDimensions.height;
                mIVTopY = mPointEndY - (mIVHeigth / 2);
                mIVTopX = mPointEndX > mHalfScreenX ? mViewDimensions.width - mIVWidth : 0;
                
                [self displayImage];
            }
        }
    }
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
    NSLog(@"onConnectionClosedWithWSReason %@", WSreason);
}

- (void)onConnectionError:(NSError*)error
{
    NSLog(@"onConnectionError: %@", error.description);
}

@end
