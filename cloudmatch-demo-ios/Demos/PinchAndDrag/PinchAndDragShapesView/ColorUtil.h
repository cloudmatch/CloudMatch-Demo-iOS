//
//  ColorUtil.h
//  CloudMatch
//
//  Created by Fabio Tiriticco on 5/05/2014.
//  Copyright (c) 2014 CloudMatch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorUtil : NSObject

// Assumes input like "#00FF00" (#RRGGBB).
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end
