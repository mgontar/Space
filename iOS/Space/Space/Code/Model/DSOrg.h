//
//  DSOrg.h
//  Space
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 DyvenSvit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSOrg : NSObject

@property (strong, atomic) NSString *orgID;

@property (strong, atomic) NSString *title;

@property (strong, atomic) NSString *address;

@property (strong, atomic) NSString *phone;

@property (strong, atomic) NSString *about;

@property (strong, atomic) NSString *email;

@property (strong, atomic) NSString *urlLogo;

@property (strong, atomic) NSArray *urlPhotos;

@property (strong, atomic) CLLocation *location;

@property (strong, atomic) NSArray *categories;

@property (atomic) BOOL favorite;

@end
