//
//  SectionLinksProvider.m
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "SectionLinksProvider.h"

@implementation SectionLinksProvider

+(nullable NSString *)urlForSection:(nonnull NSString *)section; {
    static NSDictionary<NSString *, NSString *> *section2LinkMap;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        section2LinkMap = @{
                            @"News" : @"https://cxnews.azurewebsites.net/articles/news/",
                            @"World" : @"https://cxnews.azurewebsites.net/articles/world/",
                            @"Business" : @"https://cxnews.azurewebsites.net/articles/business/",
                            @"Entertainment" : @"https://cxnews.azurewebsites.net/articles/entertainment/",
                            @"Sports" : @"https://cxnews.azurewebsites.net/articles/sports/",
                            @"Politics" : @"https://cxnews.azurewebsites.net/articles/politics/",
                            @"Health" : @"https://cxnews.azurewebsites.net/articles/health/",
                            @"Science" : @"https://cxnews.azurewebsites.net/articles/science/",
                            @"Tech" : @"https://cxnews.azurewebsites.net/articles/tech/"
                            };
    });
    return section2LinkMap[section];
}

@end
