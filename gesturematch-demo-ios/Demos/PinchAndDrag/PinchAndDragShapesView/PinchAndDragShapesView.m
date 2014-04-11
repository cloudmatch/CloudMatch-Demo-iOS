//
//  PinchAndDragShapesView.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 Fabio Tiriticco, Fabway. All rights reserved.
//

#import "PinchAndDragShapesView.h"
#import "PinchAndDragConsts.h"
#import "PinchAndDragDeliveryHelper.h"

@implementation PinchAndDragShapesView

//The border around the screen (in points) to detect when the user tapped on a border
static NSInteger const SIDE_AREA_WIDTH = 20;
static double const SHAPE_VISIBILITY_RESET_INTERVAL = 3.0; // seconds
static double const DRAGGING_CANCEL_INTERVAL = 3.0; // seconds

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        
        mCircleInitialPosition = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 3);
        mSquareInitialPosition = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 3 * 2);
        
        //Create the circles and add them as subviews
        self.mCircleView = [[CircleView alloc] initWithCenter:mCircleInitialPosition];
        self.mSquareView = [[SquareView alloc] initWithCenter:mSquareInitialPosition];

        [self addSubview:self.mCircleView];
        [self addSubview:self.mSquareView];
        
        self.mCircleView.hidden = YES;
        self.mSquareView.hidden = YES;
        
        self.mGroupId = @"";
        self.mShapeBeingDraggedOnOtherSide = @"";
        
        self.backgroundColor = [UIColor clearColor];
        
        mDeliveryHelper = [[PinchAndDragDeliveryHelper alloc] init];
        
    }
    return self;
}

#pragma mark - delivery protocol

-(void)onCointoss:(double)cointoss
{
    // if my cointoss value is greater, make shapes appear
    if (mMyCointossValue > cointoss) {
        self.mCircleView.hidden = NO;
        self.mSquareView.hidden = NO;
    }
}

-(void)onShapeDragInitiatedOnOtherSide:(NSString*)shape
{
    self.mShapeBeingDraggedOnOtherSide = [[NSString alloc] initWithString:shape];
    
    // if I don't get it after a certain time, stop waiting for it
    [self performSelector:@selector(stopWaiting) withObject:nil afterDelay:DRAGGING_CANCEL_INTERVAL];
}

-(void)stopWaiting
{
    self.mShapeBeingDraggedOnOtherSide = @"";
}

-(void)onShapeDragStoppedOnOtherSide
{
    // reset the drag information
    self.mShapeBeingDraggedOnOtherSide = @"";
}

-(void)onShapeReceivedOnOtherSide:(NSString*)shape
{
    if ([shape isEqualToString:CIRCLE_SHAPE]) {
        // the other got the circle, make it invisible
        self.mCircleView.hidden = YES;
        
        // cancel reappearing task
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    } else {
        // the other got the square, make it invisible
        self.mSquareView.hidden = YES;
        
        // cancel reappearing task
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
}

#pragma mark - on matched methods

-(void)onMatchedInGroup:(NSString *)groupId
{
    self.mGroupId = [[NSString alloc] initWithString:groupId];
    mMyCointossValue = drand48();
    [mDeliveryHelper sendCointoss:mMyCointossValue ToGroup:self.mGroupId];
}

#pragma mark - touch delegate methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Enumerate through all the touch objects.
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon.
		self.mMovingView = nil;
        self.mMovingShape = @"";
        
        CGPoint location = [touch locationInView:self];
        if (CGRectContainsPoint(self.mCircleView.frame, location) &&
            self.mCircleView.hidden == NO) {
            self.mMovingView = self.mCircleView;
            self.mMovingShape = @"circle";
            [mDeliveryHelper sendShapeDragStart:self.mMovingShape ToGroup:self.mGroupId];
        } else if (CGRectContainsPoint(self.mSquareView.frame, location) &&
            self.mSquareView.hidden == NO) {
            self.mMovingView = self.mSquareView;
            self.mMovingShape = @"square";
            [mDeliveryHelper sendShapeDragStart:self.mMovingShape ToGroup:self.mGroupId];
        } else {
            // it is an outside area. If I'm waiting for a shape, make it appear
            if (![self.mGroupId isEqualToString:@""] && ![self.mShapeBeingDraggedOnOtherSide isEqualToString:@""]) {
                NSLog(@"making a shape appear for drag");
                if ([self.mShapeBeingDraggedOnOtherSide isEqualToString:CIRCLE_SHAPE]) {
                    self.mMovingView = self.mCircleView;
                } else if ([self.mShapeBeingDraggedOnOtherSide isEqualToString:SQUARE_SHAPE]){
                    self.mMovingView = self.mSquareView;
                }
                [self animateView:self.mMovingView toPosition:location];
                self.mMovingView.hidden = NO;
                self.mMovingShape = self.mShapeBeingDraggedOnOtherSide;
            }
        }
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Enumerates through all touch objects
	for (UITouch *touch in touches) {
        if (self.mMovingView != nil) {
            [self animateView:self.mMovingView toPosition: [touch locationInView:self]];
        }
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Enumerates through all touch object
	for (UITouch *touch in touches) {
        if (self.mMovingView != nil) {
            
            CGPoint touchLoc = [touch locationInView:self];
            [self animateView:self.mMovingView toPosition:touchLoc];
            
            // if the shape has been dropped on a side, make it invisible for a certain period
            if (touchLoc.x < SIDE_AREA_WIDTH || touchLoc.x > (self.frame.size.width - SIDE_AREA_WIDTH)) {
                NSLog(@"shape dropped on the side, making it invisible for a while");
                self.mMovingView.hidden = YES;
                CGPoint tempos;
                if ([self.mMovingShape isEqualToString:CIRCLE_SHAPE]) {
                    tempos = mCircleInitialPosition;
                } else {
                    tempos = mSquareInitialPosition;
                }
                [self performSelector:@selector(resetShapeToPosition:) withObject:[NSValue valueWithCGPoint:tempos ] afterDelay:SHAPE_VISIBILITY_RESET_INTERVAL];
            } else if (![self.mGroupId isEqualToString:@""]) {
                if ([self.mShapeBeingDraggedOnOtherSide isEqualToString:@""]) {
                    // I was dragging one of my shapes and dropped it in the center
                    // move it back to initial position and send drag stop
                    NSLog(@"was dragging a shape and I dropped it in the center");
                    [mDeliveryHelper sendShapeDragStopped:self.mGroupId];
                } else {
                    // I acquired a shape
                    NSLog(@"I acquired a shape");
                    [mDeliveryHelper sendShapeReceivedAck:self.mShapeBeingDraggedOnOtherSide ToGroup:self.mGroupId];
                }
                if ([self.mMovingShape isEqualToString:CIRCLE_SHAPE]) {
                    self.mMovingView.center = mCircleInitialPosition;
                } else {
                    self.mMovingView.center = mSquareInitialPosition;
                }
            }
        }
	}
}

-(void)resetShapeToPosition:(NSValue*)position
{
    // make it visible again and put it back into initial position
    self.mMovingView.hidden = NO;
    self.mMovingView.center = [position CGPointValue];
}

-(void)removeTinyCircle:(NSValue*)ignore
{
    [self.mTinyCircleView removeFromSuperview];
}

-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.15];
	theView.center = thePosition;
	[UIView commitAnimations];
}

#pragma mark - onMovementDelegate

-(void)onMovementDetection:(Movement)movement swipeType:(SwipeType)swipeType pointStart:(CGPoint)pointStart pointEnd:(CGPoint)pointEnd
{
    // cancel previous stuff
    [self.mTinyCircleView removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeTinyCircle:) object:nil];
    
    NSInteger size = 20;
    CGFloat circleX = pointEnd.x;
    switch (movement) {
        case kMovementInnerRight:
            circleX = circleX - size;
            break;
            
        default:
            break;
    }
    
    NSLog(@"onMovementDetection: (%f, %f) to (%f, %f)", pointStart.x, pointStart.y, pointEnd.x, pointEnd.y);
    CGRect rect = CGRectMake(circleX, pointEnd.y, size, size);
    self.mTinyCircleView = [[TinyCircleView alloc] initWithFrame:rect];
    [self addSubview:self.mTinyCircleView];
    
    // remove it after a bit
    [self performSelector:@selector(removeTinyCircle:) withObject:nil afterDelay:SHAPE_VISIBILITY_RESET_INTERVAL];
}

- (BOOL)isSwipeValid
{
    // stop sending match requests out if we're already part of a group
    return self.mGroupId == nil || [self.mGroupId isEqualToString:@""];
}

- (NSString *)getEqualityParam
{
    return @"";
}

@end
