//
//  GeoCoordinatesParser.h
//  Space
//
//  Created by Admin on 11/21/14.
//  Copyright (c) 2014 DyvenSvit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoCoordinatesParser : NSObject
+(CLLocation*)getLocationFromString:(NSString*)value;
+(NSString*)getStringFromLocation:(CLLocation*)value;
@end
