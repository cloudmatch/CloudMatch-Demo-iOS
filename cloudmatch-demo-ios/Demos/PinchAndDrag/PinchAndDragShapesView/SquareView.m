//
//  SquareView.m
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import "SquareView.h"
#import "ColorUtil.h"

@implementation SquareView

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
    CGSize squareSize = CGSizeMake(70.0, 70.0);
    CGRect frame = CGRectMake(center.x - squareSize.width/2, center.y - squareSize.height/2, squareSize.width, squareSize.height);
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
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:rect];
    UIColor *fillColor = [ColorUtil colorFromHexString:@"#13B4DB"];
    [fillColor setFill];
    [bezierPath fill];
}

@end
