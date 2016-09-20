//
// Created by Anver Bogatov on 07.06.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterestModel.h"

@class UserModel;

static NSString *kUserDataURL = @"http://cxcrm.azurewebsites.net/Customer/Details";

@interface UserProfileService : NSObject

/**
 * Get specific for current user data.
 */
- (UserModel *)dataForUserWithExternalId:(NSString *)externalId;

- (void)loadInterestsForUserWithExternalId:(NSString *)externalId
                            withCompletion:(void (^)(NSArray<InterestModel *> *))completion;

/**
 * Get single instance of current service.
 */
+ (instancetype)sharedInstance;
@end