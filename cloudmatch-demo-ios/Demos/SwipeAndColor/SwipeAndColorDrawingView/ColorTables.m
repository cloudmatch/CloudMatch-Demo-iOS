//
//  ColorTables.m
//  CloudMatch
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 cloudmatch.io . All rights reserved.
//

#import "ColorTables.h"

@implementation ColorTables

// Assumes input like "#00FF00" (#RRGGBB).
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(NSArray*)getColorTableOfSize:(NSInteger)size
{
    static NSArray *table2;
    static NSArray *table3;
    static NSArray *table4;
    static NSArray *table5;
    static NSArray *table6;
    static NSArray *table7;
    static NSArray *table8;
    
    UIColor* cloudmatchRed = [self colorFromHexString:@"#EB5F60"];
    UIColor* cloudmatchBlue = [self colorFromHexString:@"#13B4DB"];
    
    
    switch (size) {
        case 2:
            if (!table2)
            {
                table2 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue, nil];
            }
            return table2;
            break;
        case 3:
            if (!table3)
            {
                table3 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue,
                          [UIColor greenColor], nil];
            }
            return table3;
            break;
        case 4:
            if (!table4)
            {
                table4 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue,
                          [UIColor greenColor],
                          [UIColor yellowColor], nil];
            }
            return table4;
            break;
        case 5:
            if (!table5)
            {
                table5 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue,
                          [UIColor greenColor],
                          [UIColor yellowColor],
                          [UIColor blackColor],
                          nil];
            }
            return table5;
            break;
        case 6:
            if (!table6)
            {
                table6 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue,
                          [UIColor greenColor],
                          [UIColor yellowColor],
                          [UIColor blackColor],
                          [UIColor grayColor],
                          nil];
            }
            return table6;
            break;
        case 7:
            if (!table7)
            {
                table7 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue,
                          [UIColor greenColor],
                          [UIColor yellowColor],
                          [UIColor blackColor],
                          [UIColor grayColor],
                          [UIColor cyanColor], nil];
            }
            return table7;
            break;
        case 8:
            if (!table8)
            {
                table8 = [[NSArray alloc] initWithObjects:cloudmatchRed,
                          cloudmatchBlue,
                          [UIColor greenColor],
                          [UIColor yellowColor],
                          [UIColor blackColor],
                          [UIColor grayColor],
                          [UIColor cyanColor],
                          [UIColor magentaColor], nil];
            }
            return table8;
            break;
        default:
            return nil;
            break;
    }
}


@end
