//
//  CircleView.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/14.
//  Copyright (c) 2014 Fabio Tiriticco. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.startingPosition = CGPointMake(frame.origin.x + (frame.size.width/2), frame.origin.y + (frame.size.height/ 2));
    }
    return self;
}

- (id)initWithCenter:(CGPoint)center
{
    CGSize circleSize = CGSizeMake(70.0, 70.0);
    CGRect frame = CGRectMake(center.x - circleSize.width/2, center.y - circleSize.height/2, circleSize.width, circleSize.height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.startingPosition = center;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIColor *fillColor = [UIColor redColor];
    [fillColor setFill];
    [bezierPath fill];
}


@end
