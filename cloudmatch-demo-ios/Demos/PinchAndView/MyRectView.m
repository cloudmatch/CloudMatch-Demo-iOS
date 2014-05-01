//
//  MyRectView.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 6/04/2014.
//  Copyright (c) 2014 Fabway. All rights reserved.
//

#import "MyRectView.h"

@implementation MyRectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] setFill];
    UIBezierPath *sideRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [sideRect fill];
}

@end
