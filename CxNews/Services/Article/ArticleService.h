//
//  ArticleService.h
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;
@class ArticleModel;
@protocol ArticleLoader;

/**
 ArticleService provides articles content from CxNews web site.
 */
@interface ArticleService : NSObject <ArticleLoader>

/**
 Initialized instance of the service.

 @return initialized service instance
 */
+ (nonnull instancetype)sharedInstance;

@end
