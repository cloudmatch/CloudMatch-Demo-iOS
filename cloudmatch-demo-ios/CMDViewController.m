//
//  CMDViewController.m
//  CloudMatch
//
//  Created by Fabio Tiriticco on 11/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "CMDViewController.h"
#import <CloudMatchSDK/CloudMatchSDK.h>

@interface CMDViewController ()

@end

@implementation CMDViewController

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
