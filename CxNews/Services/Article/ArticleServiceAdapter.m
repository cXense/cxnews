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
}

-(instancetype)init {
    if (self = [super init]) {
        _underlyingService = [ArticleService sharedInstance];
    }
    return self;
}

-(void)articleForURL:(nonnull NSURL *)url
          completion:(_Nonnull SoloArticleModelCompletion)completion {

}

-(void)articlesForURL:(nonnull NSURL *)url
           completion:(_Nonnull MultipleArticleModelCompletion)completion {

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
