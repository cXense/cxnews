//
// Created by Anver Bogatov on 07.06.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

/**
 * Instances of that class describe information about current user.
 */
@interface UserModel : NSObject

/** URL to image with avatar of the user. */
@property NSString *avatarUrl;
/** Name of the user. */
@property NSString *name;
/** Email of the user. */
@property NSString *email;
/** Gender of the user. */
@property NSString *gender;
/** Birth year of the user. */
@property NSString *birthYear;
/** Cxense external id of the user. */
@property NSString *externalId;
/** User location. */
@property NSString *location;

@end