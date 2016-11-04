//
//  NewsStorage.m
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "NewsStorage.h"

@implementation NewsStorage

+(instancetype)sharedInstance {
    static NewsStorage *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        [instance setNews:[NSArray new]];
    });
    return instance;
}

-(void)setNews:(NSArray<NewsModel *> *)news {
    _news = news;
    if (self.delegate) {
        [self.delegate newsDataSourceWasUpdated];
    }
}

@end
