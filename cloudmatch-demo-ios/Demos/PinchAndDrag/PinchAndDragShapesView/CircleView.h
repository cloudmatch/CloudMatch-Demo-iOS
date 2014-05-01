//
//  CircleView.h
//  CloudMatch Demo
//
//  Created by Fabio Tiriticco on 25/03/14.
//  Copyright (c) 2014 cloudmatch.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (nonatomic, assign) CGPoint startingPosition;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithCenter:(CGPoint)center;

@end
