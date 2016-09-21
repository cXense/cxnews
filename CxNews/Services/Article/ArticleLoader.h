//
//  ArticleLoader.h
//  CxNews
//
//  Created by Anver Bogatov on 21.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleModel.h"

typedef void(^SoloArticleModelCompletion)(ArticleModel * _Nullable , NSError * _Nullable);
typedef void(^MultipleArticleModelCompletion)(NSSet<ArticleModel *> * _Nullable, NSError * _Nullable);

/**
 The ArticleLoader protocol groups methods that are
 responsible for CxNews articles' load.
 */
@protocol ArticleLoader <NSObject>

/**
 Perform asynchronous load of article located in specified url.
 As it asynchronous operation, return value will be pushed to completion block
 as soon as data retrieval will be finished.

 Pay attention that specified url point to article located in CxNews web site.

 @param url        url of CxNews article
 @param completion provides single loaded article or error if was thrown
 */
-(void)articleForURL:(nonnull NSURL *)url
          completion:(_Nonnull SoloArticleModelCompletion)completion;


/**
 Perform asynchronous load of article located in specified url.
 As it asynchronous operation, return value will be pushed to completion block
 as soon as data retrieval will be finished.

 Pay attention that specified url point to article located in CxNews web site.

 @param url        url of CxNews article
 @param completion provides multiple instances of articles from specified url or error if was thrown
 */
-(void)articlesForURL:(nonnull NSURL *)url
           completion:(_Nonnull MultipleArticleModelCompletion)completion;

@end
