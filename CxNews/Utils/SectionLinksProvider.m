//
//  SectionLinksProvider.m
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "SectionLinksProvider.h"

static NSDictionary<NSString *, NSString *> *section2LinkMap;

@implementation SectionLinksProvider

+(void)initialize {
    if (self == [SectionLinksProvider class]) {
        section2LinkMap = @{
                            @"News" : @"http://cxnews.azurewebsites.net/articles/news/",
                            @"World" : @"http://cxnews.azurewebsites.net/articles/world/",
                            @"Business" : @"http://cxnews.azurewebsites.net/articles/business/",
                            @"Entertainment" : @"http://cxnews.azurewebsites.net/articles/entertainment/",
                            @"Sports" : @"http://cxnews.azurewebsites.net/articles/sports/",
                            @"Politics" : @"http://cxnews.azurewebsites.net/articles/politics/",
                            @"Health" : @"http://cxnews.azurewebsites.net/articles/health/",
                            @"Science" : @"http://cxnews.azurewebsites.net/articles/science/",
                            @"Tech" : @"http://cxnews.azurewebsites.net/articles/tech/"
                            };
    }
}

+(nullable NSString *)urlForSection:(nonnull NSString *)section; {
    return section2LinkMap[section];
}

+(nonnull NSArray<NSString *> *)supportedSiteSectionURLs {
    return section2LinkMap.allValues;
}

@end
