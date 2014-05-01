//
//  ColorTables.m
//  gesturematch-demo-ios
//
//  Created by Fabio Tiriticco on 24/03/2014.
//  Copyright (c) 2014 FabioTiriticco, Fabway. All rights reserved.
//

#import "ColorTables.h"

@implementation ColorTables

+(NSArray*)getColorTableOfSize:(NSInteger)size
{
    static NSArray *table2;
    static NSArray *table3;
    static NSArray *table4;
    static NSArray *table5;
    static NSArray *table6;
    static NSArray *table7;
    static NSArray *table8;
    
    switch (size) {
        case 2:
            if (!table2)
            {
                table2 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor], nil];
            }
            return table2;
            break;
        case 3:
            if (!table3)
            {
                table3 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor blueColor], nil];
            }
            return table3;
            break;
        case 4:
            if (!table4)
            {
                table4 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor blueColor],
                          [UIColor yellowColor], nil];
            }
            return table4;
            break;
        case 5:
            if (!table5)
            {
                table5 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor blueColor],
                          [UIColor yellowColor],
                          [UIColor blackColor],
                          nil];
            }
            return table5;
            break;
        case 6:
            if (!table6)
            {
                table6 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor blueColor],
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
                table7 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor blueColor],
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
                table8 = [[NSArray alloc] initWithObjects:[UIColor redColor],
                          [UIColor greenColor],
                          [UIColor blueColor],
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
