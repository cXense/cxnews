//
//  CachedArticleService.m
//  CxNews
//
//  Created by Anver Bogatov on 21.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "ArticleServiceAdapter.h"
#import "ArticleService.h"

@implementation ArticleServiceAdapter {
    ArticleService *_underlyingService;
    NSDictionary<NSString *, NSSet<ArticleModel *> *> *sectionCache;
    NSDictionary<NSString *, ArticleModel *> *articleCache;
}

-(instancetype)init {
    if (self = [super init]) {
        _underlyingService = [ArticleService sharedInstance];
    }
    return self;
}

-(void)articleForURL:(nonnull NSURL *)url
          completion:(_Nonnull SoloArticleModelCompletion)completion {
    NSString *articleUrl = [url absoluteString];
    ArticleModel *result = [articleCache valueForKey:articleUrl];
    if (result) {
        NSLog(@"ArticleModel for '%@' has been resolved from cache", articleUrl);
        completion(result, nil);
    } else {
        NSLog(@"Resolving ArticleModel for '%@' from network", articleUrl);
        [_underlyingService articleForURL:url
                               completion:^(ArticleModel * _Nullable article, NSError * _Nullable error) {
                                   if (article && error == nil) {
                                       [articleCache setValue:article
                                                       forKey:articleUrl];
                                   }
                                   completion(article, error);
                               }];
    }
}

-(void)articlesForURL:(nonnull NSURL *)url
           completion:(_Nonnull MultipleArticleModelCompletion)completion {
    NSString *sectionUrl = [url absoluteString];
    NSSet<ArticleModel *> *result = [sectionUrl valueForKey:sectionUrl];
    if (result) {
        NSLog(@"Articles for '%@' have been resolved from cache", sectionUrl);
        completion(result, nil);
    } else {
        NSLog(@"Resolving ArticleModel for '%@' from network", sectionUrl);
        [_underlyingService articlesForURL:url
                                completion:^(NSSet<ArticleModel *> * _Nullable articles, NSError * _Nullable error) {
                                    if (articles && error == nil) {
                                        [sectionCache setValue:articles
                                                        forKey:sectionUrl];
                                    }
                                    completion(articles, error);
                                }];
    }
}

+ (nonnull instancetype)sharedInstance {
    static ArticleServiceAdapter * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
