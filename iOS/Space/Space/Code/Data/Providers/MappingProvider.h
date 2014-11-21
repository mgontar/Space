//
//  MappingProvider.h
//  Space
//
//  Created by Admin on 11/21/14.
//  Copyright (c) 2014 DyvenSvit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyMapping.h"
#import "DSOrg.h"
#import "DSPlace.h"
#import "DSEvent.h"
#import "GeoCoordinatesParser.h"

@interface MappingProvider : NSObject
+ (EKObjectMapping *)orgMapping;
+ (EKObjectMapping *)placeMapping;
+ (EKObjectMapping *)eventMapping;
@end
