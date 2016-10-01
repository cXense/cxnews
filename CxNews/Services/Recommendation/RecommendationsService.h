//
//  RecommendationsService.h
//  CxNews
//
//  Created by Anver Bogatov on 21.05.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;

#import "CxenseContentRecommendation.h"

/**
 * Cx news site main URL.
 */
static NSString *const CX_NEWS_URL = @"http://cxnews.azurewebsites.net";
/**
 * Cxense Content widget id.
 */
static NSString *const CXENSE_CONTENT_WIDGET_ID = @"bb70b171687ed2aa35ae1197fbed5109cacc8c57";

@interface RecommendationsService : NSObject

/**
 * Request content recommendations from Cxense Content API
 * and return it as array of CxenseContentRecommendation descriptors.
 */
- (void)fetchRecommendationsForUserWithExternalId:(NSString *)externalId
                                     withCallback:(void (^)(BOOL success, NSArray *items, NSError *error))callback;

@end
