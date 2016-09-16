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

-(void)articleForURL:(nonnull NSURL *)url
          completion:(void(^ _Nonnull)( ArticleModel * _Nonnull model, NSError * _Nonnull error))completion;

-(void)articlesForURL:(nonnull NSURL *)url
           completion:(void( ^ _Nonnull )(NSSet<ArticleModel *> * _Nonnull articles, NSError * _Nonnull error))completion;

/**
 Initialized instance of the service.

 @return single instance for the app
 */
+ (nonnull instancetype)sharedInstance;

@end
