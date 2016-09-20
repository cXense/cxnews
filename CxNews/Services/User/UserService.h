//
// Created by Anver Bogatov on 28.05.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AuthorizationResult) {
    OK,
    AlreadyLoggedIn,
    Failed
};

@interface UserService : NSObject

/**
 * Shows if current user is authorized already.
 */
- (BOOL)isUserAuthorized;

/**
 * Returns external identifier of current user.
 * If user not logged in this method will return IDFA specifically
 * for working in 'guest' mode.
 */
- (NSString *)userExternalId;

/**
 * Returns identifier of current user profile.
 */
- (NSString *)userProfileId;

/**
 * Perform authorization process with specific parameters.
 * @param login user login
 * @param password user password
 * @return YES if authorization process was finished with success
 */
- (AuthorizationResult)authWithLogin:(NSString *)login
                         andPassword:(NSString *)password;

/**
 * Perform logout process.
 * During logout two actions will be executed:
 *  - any user data provided by this service will be removed
 *  - network caches will be removed (this is needed to invalidate cookies)
 */
- (void)logout;

/**
 * Get shared instance of UserService that will handle
 * all auth operations of the application.
 */
+ (instancetype)sharedInstance;
@end