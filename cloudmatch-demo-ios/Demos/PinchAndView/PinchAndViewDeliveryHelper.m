//
//  PinchAndViewDeliveryHelper.m
//  CloudMatch
//
//  Created by Fabio Tiriticco on 5/05/2014.
//  Copyright (c) 2014 CloudMatch. All rights reserved.
//

#import "PinchAndViewDeliveryHelper.h"
#import <CloudMatchSDK/CloudMatchSDK.h>

NSString* const IMAGE_HEIGHT = @"imgHeight";

@implementation PinchAndViewDeliveryHelper

+(void)sendImageHeight:(NSInteger)imageHeight ToGroup:(NSString *)groupId
{
    // prepare JSON and deliver it
    NSNumber* imgHeight = [[NSNumber alloc] initWithInteger:imageHeight];
    NSString* toSend = [PinchAndViewDeliveryHelper getJSONStringFromKey:IMAGE_HEIGHT AndObject:imgHeight];
    [[CMCloudMatchClient sharedInstance] deliverPayload:toSend toGroup:groupId];
}

+(NSString*)getJSONStringFromKey:(NSString*)key AndObject:(NSObject*)value
{
    // prepare JSON and deliver it
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:value forKey:key];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
