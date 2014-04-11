//
//  SwipeAndColorDemoViewController.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import "SwipeAndColorDemoViewController.h"
#import "SwipeAndColorServerEventDelegate.h"
#import "ColorTables.h"

static NSString* const ROTATION_MESSAGE = @"rotation";

@interface SwipeAndColorDemoViewController ()

@end

@implementation SwipeAndColorDemoViewController

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
    
    [[GMGestureMatchClient sharedInstance] attachToView:drawingView withMovementDelegate:drawingView criteria:kGMCriteriaSwipe];
    [[GMGestureMatchClient sharedInstance] setServerEventDelegate:serverEventDelegate];
    [[GMGestureMatchClient sharedInstance] connect];
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
    [[GMGestureMatchClient sharedInstance] deliverPayload:jsonString toGroup:mGroupId];
}

- (void)onMatchedInGroup:(NSString*)groupId Size:(NSInteger)size MyId:(NSInteger)myId{
    NSLog(@"matched callback!");
    // choose the right color table
    mColorTable = [ColorTables getColorTableOfSize:size];
    mCurrentColorIndex = myId;
    mGroupId = groupId;
    
    [self setNewColor];
    
    if (mChangeColorButton == nil) {
        mChangeColorButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [mChangeColorButton addTarget:self action:@selector(onChangeColorTap:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:mChangeColorButton];
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
