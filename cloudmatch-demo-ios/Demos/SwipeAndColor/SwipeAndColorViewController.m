//
//  SwipeAndColorDemoViewController.m
//  CloudMatch
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "SwipeAndColorViewController.h"
#import "SwipeAndColorServerEventDelegate.h"
#import "ColorTables.h"

static NSString* const ROTATION_MESSAGE = @"rotation";

@interface SwipeAndColorViewController ()

@end

@implementation SwipeAndColorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"SwipeAndColor Demo starting");
    
    // the frame here below should adapt to the device that this app is running on
    drawingView = [[SwipeAndColorDrawingView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:drawingView];
    [self.view sendSubviewToBack:drawingView];
    
    mGroupId = @"";
    
    serverEventDelegate = [[SwipeAndColorServerEventDelegate alloc] init];
    [serverEventDelegate setOnMatchedDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    // TODO: if you want to build this, request a free pair of apiKey / appId on cloudmatch.io!
    NSString* myApiKey = @"DUMMY-API-KEY";
    NSString* myAppId = @"DUMMY-APP-ID";
    
    [[CMCloudMatchClient sharedInstance] attachToView:drawingView withMovementDelegate:drawingView criteria:kCMCriteriaSwipe];
    [[CMCloudMatchClient sharedInstance] setServerEventDelegate:serverEventDelegate apiKey:myApiKey appId:myAppId];
    [[CMCloudMatchClient sharedInstance] connect];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[CMCloudMatchClient sharedInstance] closeConnection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onChangeColorTap:(id)sender
{
    [self setNewColor];
    
    // prepare JSON and deliver it
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:ROTATION_MESSAGE];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[CMCloudMatchClient sharedInstance] deliverPayload:jsonString toGroup:mGroupId];
}

# pragma mark - OnMatchedProtocol

- (void)onMatchedInGroup:(NSString*)groupId Size:(NSInteger)size MyId:(NSInteger)myId{
    NSLog(@"matched callback!");
    // choose the right color table
    mColorTable = [ColorTables getColorTableOfSize:size];
    mCurrentColorIndex = myId;
    mGroupId = groupId;
    mGroupSize = size;
    
    [self setNewColor];
    [drawingView clearScreen];
    
    if (mChangeColorButton == nil) {
        mChangeColorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [mChangeColorButton addTarget:self action:@selector(onChangeColorTap:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:mChangeColorButton];
    }
}

-(void)onMatheeLeft
{
    // if nobody is in the group anymore, let's quit it.
    mGroupSize = mGroupSize - 1;
    if (mGroupSize <= 1) {
        self.view.backgroundColor = [UIColor whiteColor];
        [mChangeColorButton removeFromSuperview];
        mChangeColorButton = nil;
        NSLog(@"everybody left");
    }
}

-(void)onDelivery:(NSString *)payload
{
    NSData *jsonData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    if ([jsonDict objectForKey:ROTATION_MESSAGE] != nil) {
        [self setNewColor];
    }
}

-(void)setNewColor
{
    mCurrentColorIndex = (mCurrentColorIndex + 1) % [mColorTable count];
    UIColor *newColor = [mColorTable objectAtIndex:mCurrentColorIndex];
    self.view.backgroundColor = newColor;
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

@end
