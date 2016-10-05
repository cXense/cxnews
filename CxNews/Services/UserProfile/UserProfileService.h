//
// Created by Anver Bogatov on 07.06.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;

@class InterestModel, UserModel;

/**
 User Profile Service is responsible for retrieving user data from Cxense API.
 */
@interface UserProfileService : NSObject

/**
 Get specific for current user data.

 @param externalId Cxense user external id

 @return model of user with specified id
 */
- (UserModel *)dataForUserWithExternalId:(NSString *)externalId;


/**
 Load interests models for specified user from Cxense API.

 @param externalId Cxense user external id
 @param completion callback that will be invoked with loaded interest models
 */
- (void)loadInterestsForUserWithExternalId:(NSString *)externalId
                            withCompletion:(void (^)(NSArray<InterestModel *> *))completion;

/**
 Get single instance of current service.

 @return initialized service instance
 */
+ (instancetype)sharedInstance;
@end
