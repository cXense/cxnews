//
//  SectionLinksProvider.m
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "SectionLinksProvider.h"
#import "Constants.h"

static NSDictionary<NSString *, NSString *> *section2LinkMap;

@implementation SectionLinksProvider

+(void)initialize {
    if (self == [SectionLinksProvider class]) {
        section2LinkMap = @{
                            @"News" : [NSString stringWithFormat:@"%@/articles/news/", kCxenseSiteBaseUrl],
                            @"World" : [NSString stringWithFormat:@"%@/articles/world/", kCxenseSiteBaseUrl],
                            @"Business" : [NSString stringWithFormat:@"%@/articles/business/", kCxenseSiteBaseUrl],
                            @"Entertainment" : [NSString stringWithFormat:@"%@/articles/entertainment/", kCxenseSiteBaseUrl],
                            @"Sports" : [NSString stringWithFormat:@"%@/articles/sports/", kCxenseSiteBaseUrl],
                            @"Politics" : [NSString stringWithFormat:@"%@/articles/politics/", kCxenseSiteBaseUrl],
                            @"Health" : [NSString stringWithFormat:@"%@/articles/health/", kCxenseSiteBaseUrl],
                            @"Science" : [NSString stringWithFormat:@"%@/articles/science/", kCxenseSiteBaseUrl],
                            @"Tech" : [NSString stringWithFormat:@"%@/articles/tech/", kCxenseSiteBaseUrl]
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
