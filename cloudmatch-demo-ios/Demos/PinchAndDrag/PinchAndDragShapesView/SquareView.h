//
//  SquareView.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 25/03/2014.
//  Copyright (c) 2014 cloudmatch.io All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareView : UIView

@property (nonatomic, assign) CGPoint startingPosition;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithCenter:(CGPoint)center;

@end
