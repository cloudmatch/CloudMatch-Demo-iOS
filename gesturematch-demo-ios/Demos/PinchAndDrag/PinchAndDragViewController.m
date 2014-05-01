//
//  PinchAndDragViewController.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import "PinchAndDragViewController.h"
#import "PinchAndDragShapesView.h"
#import "PinchAndDragServerEventDelegate.h"

@implementation PinchAndDragViewController

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
    // Do any additional setup after loading the view.
    
    mShapesView = [[PinchAndDragShapesView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mShapesView];
    
    mServerEventDelegate = [[PinchAndDragServerEventDelegate alloc] init];
    [mServerEventDelegate setMatchedDelegate:mShapesView];
    [mServerEventDelegate setDeliveryDelegate:mShapesView];
    
    [[CMCloudMatchClient sharedInstance] attachToView:mShapesView withMovementDelegate:mShapesView criteria:kCMCriteriaPinch];
    [[CMCloudMatchClient sharedInstance] setServerEventDelegate:mServerEventDelegate];
    [[CMCloudMatchClient sharedInstance] connect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
