//
//  DSEvent.h
//  Space
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 DyvenSvit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSEvent : NSObject

@property (strong, atomic) NSString *eventID;

@property (strong, atomic) NSString *title;

@property (strong, atomic) NSString *about;

@property (strong, atomic) NSDate *dateBegin;

@property (strong, atomic) NSDate *dateEnd;

@property (strong, atomic) NSArray *places;

@property (strong, atomic) NSArray *orgs;

@property (strong, atomic) NSString *website;

@property (strong, atomic) NSString *email;

@property (strong, atomic) NSArray *urlPhotos;

@property (strong, atomic) NSArray *categories;

@property (strong, atomic) NSString *tags;

@property (atomic) NSInteger ticketPriceMin;

@property (atomic) NSInteger ticketPriceMax;

@end
