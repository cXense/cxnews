//
//  CachedArticleService.h
//  CxNews
//
//  Created by Anver Bogatov on 21.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleLoader.h"

@interface ArticleServiceAdapter : NSObject <ArticleLoader>

/**
 Removes all entries stored in in-memory cache.
 */
- (void) clear;

/**
 Initialized instance of the service.

 @return initialized instance
 */
+ (nonnull instancetype)sharedInstance;

@end
