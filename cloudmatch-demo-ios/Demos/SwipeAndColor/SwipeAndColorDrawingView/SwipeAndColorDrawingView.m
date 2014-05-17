//
//  DrawingView.m
//  DrawLinesInnerOuter
//
//  Created by Fabio Tiriticco on 30/10/12.
//  Copyright (c) 2012 Fabio Tiriticco. All rights reserved.
//

#import "SwipeAndColorDrawingView.h"

@implementation SwipeAndColorDrawingView 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        myPath=[[UIBezierPath alloc] init];
        myPath.lineCapStyle = kCGLineCapRound;
        myPath.miterLimit = 0;
        myPath.lineWidth = 6;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor blackColor] setStroke];
    [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
}

#pragma mark - Touch Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    CGPoint np = [mytouch locationInView:self];
//    NSLog(@"touch began, %f, %f", np.x, np.y);
    [myPath removeAllPoints];
    [myPath moveToPoint:np];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    CGPoint np = [mytouch locationInView:self];
//    NSLog(@"touch moved, %f, %f", np.x, np.y);
    [myPath addLineToPoint:np];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    CGPoint np = [mytouch locationInView:self];
//    NSLog(@"touch ended, %f, %f", np.x, np.y);
    [myPath addLineToPoint:np];
    [self setNeedsDisplay];
}

-(void)clearScreen
{
    [myPath removeAllPoints];
    [self setNeedsDisplay];
}


#pragma mark - onMovementDelegate

-(void)onMovementDetection:(Movement)movement swipeType:(SwipeType)swipeType pointStart:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd
{
    // do nothing
}

- (BOOL)isSwipeValid
{
    // always valid in this demo
    return YES;
}

- (NSString *)getEqualityParam
{
    return @"";
}

@end
