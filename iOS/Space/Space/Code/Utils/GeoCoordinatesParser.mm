//
//  GeoCoordinatesParser.m
//  Space
//
//  Created by Admin on 11/21/14.
//  Copyright (c) 2014 DyvenSvit. All rights reserved.
//

#import "GeoCoordinatesParser.h"
#include "llstr.h"
@implementation GeoCoordinatesParser

+(CLLocation*)getLocationFromString:(NSString*)value
{
    NSArray *components = [value componentsSeparatedByString:@";"];
    CLongLatString llstrLat([components[0] UTF8String]);
    CLongLatString llstrLon([components[1] UTF8String]);
    
    CLLocation *result = [[CLLocation alloc] initWithLatitude:llstrLat.GetDecimalDegree() longitude:llstrLon.GetDecimalDegree()];
    
    return result;
}

+(NSString*)getStringFromLocation:(CLLocation*)value
{
    CLongLatString llstrLat(value.coordinate.latitude, LL_LATITUDE);
    CLongLatString llstrLon(value.coordinate.longitude, LL_LONGITUDE);
    
    
    NSString *lat = [NSString stringWithCString:llstrLat.Format("%D°%M'%S\"%H").c_str()
                                       encoding:[NSString defaultCStringEncoding]];
    NSString *lon = [NSString stringWithCString:llstrLon.Format("%D°%M'%S\"%H").c_str()
                                       encoding:[NSString defaultCStringEncoding]];
    
    NSString *result = [NSString stringWithFormat:@"%@;%@",lat,lon];
    
    return result;
}

@end
