//
//  ArticleService.h
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

/** ArticleService provides articles content from CxNews web site. */
@interface ArticleService : NSObject
/**
 Load article content of provided URL.
 <b>Note</b>: Pay attention that specified URL must point to exact article on CxNews web site.
 @return model that represents article's content
 */
-(nullable ArticleModel *) articleForURL:(nonnull NSURL *)url
                                   error:(NSError **)error;

-(void)articleForURL:(nonnull NSURL *)url
          completion:(void(^)(ArticleModel *model, NSError *error))completion;

-(void)articlesForURL:(nonnull NSURL *)url
           completion:(void(^)(NSSet<ArticleModel *> *articles, NSError *error))completion;
/**
 Load articles contents of provided URL.
 <b>Note</b>: Pay attention that specified URL must point to exact section of CxNews web site.
 @return model that represents content of the articles from certain site's section
 */
-(nullable NSSet<ArticleModel *> *) articlesForURL:(nonnull NSURL *)url
                                             error:(NSError **)error;

/** Initialized instance of the service */
+ (nonnull instancetype)sharedInstance;

@end
