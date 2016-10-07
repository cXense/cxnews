//
//  RecommendationsService.h
//  CxNews
//
//  Created by Anver Bogatov on 21.05.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;

@interface RecommendationsService : NSObject

/**
 Request content recommendations from Cxense Content API
 and return it as array of CxenseContentRecommendation descriptors.

 @param externalId Cxense user external id
 @param callback   callback that will be invoked as soon as recommendations will be loaded
 */
- (void)fetchRecommendationsForUserWithExternalId:(NSString *)externalId
                                     withCallback:(void (^)(BOOL success, NSArray *items, NSError *error))callback;

@end
