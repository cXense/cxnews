//
//  CxenseContentRecommendation.h
//  CxenseContent
//
//  Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CxenseContentRecommendation : NSObject

/**
 *  The URL
 */
@property(nonatomic, strong, readonly) NSString *url;

/**
 *  The click URL for the recommendation. The default behavior is that this url (if set) redirects to the URL for the recommendation.
 */
@property(nonatomic, strong, readonly) NSString *clickUrl;

/**
 *  A dictionary representation of the raw recommendation data (JSON).
 */
@property(nonatomic, strong, readonly) NSDictionary<NSString *, id> *data;

- (instancetype)initWithRecommendationDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
