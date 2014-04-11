//
//  LBGMDViewController.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 11/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import "GMDViewController.h"
#import <GestureMatchSDK/GestureMatchSDK.h>

@interface GMDViewController ()

@end

@implementation GMDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
