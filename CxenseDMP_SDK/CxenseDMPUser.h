//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CxenseDMPProfile;


@interface CxenseDMPUser : NSObject

/**
* The user identifier.
*/
@property(nonatomic, copy) NSString *userId;

/**
* The user identifier type.
*/
@property(nonatomic, copy) NSString *userType;

/**
* Array of CxenseDMPProfile objects, containing the available parts of the user profile.
*/
@property(nonatomic, strong) NSArray<CxenseDMPProfile *> *profiles;

/**
* Array of CxenseDMPUserIdentifier objects, containing the identities the user is known as.
*/
@property(nonatomic, strong) NSArray *identityTypes;

/**
* Creates and returns a CxenseDMPUser object with the specified parameters.
*
* @param userId         The user identifier.
* @param type           The user identifier type.
* @param profiles       Array of CxenseDMPProfile objects, containing the available parts of
*                       the user profile.
* @param identityTypes  Array of CxenseDMPUserIdentifier objects, containing the identities
*                       the user is known as.
*/
+ (CxenseDMPUser *)userWithId:(NSString *)userId
                         type:(NSString *)type
                     profiles:(NSArray<CxenseDMPProfile *> *)profiles
                identityTypes:(NSArray *)identityTypes;

@end

