//
//  TinyCircleView.m
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 6/04/2014.
//  Copyright (c) 2014 cloudmatch.io. All rights reserved.
//

#import "TinyCircleView.h"

@implementation TinyCircleView

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
    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:box];
    [circle fill];
}

@end
