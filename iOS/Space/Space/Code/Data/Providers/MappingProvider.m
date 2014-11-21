//
//  MappingProvider.m
//  Space
//
//  Created by Admin on 11/21/14.
//  Copyright (c) 2014 DyvenSvit. All rights reserved.
//

#import "MappingProvider.h"

@implementation MappingProvider

+ (EKObjectMapping *)orgMapping
{
    return [EKObjectMapping mappingForClass:[DSOrg class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapFieldsFromArray:@[@"title", @"address", @"phone", @"email", @"about", @"urlLogo", @"urlPhotos", @"categories"]];
        [mapping mapFieldsFromDictionary:@{@"id":@"orgID"}];
        [mapping mapKey:@"coordinates" toField:@"location" withValueBlock:^(NSString *key, NSString *value) {
            return [GeoCoordinatesParser getLocationFromString:value];
        } withReverseBlock:^(CLLocation *location) {
            return [GeoCoordinatesParser getStringFromLocation:location];
        }];
    }];
}
//+ (EKObjectMapping *)placeMapping;
//+ (EKObjectMapping *)eventMapping;

@end
