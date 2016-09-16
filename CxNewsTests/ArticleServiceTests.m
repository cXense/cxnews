//
//  ArticleServiceTests.m
//  CxNews
//
//  Created by Anver Bogatov on 13.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArticleService.h"

@interface ArticleServiceTests : XCTestCase

@end

@implementation ArticleServiceTests

- (void)testPerformanceExample {
    NSURL *techSectionUrl = [NSURL URLWithString:@"https://cxnews.azurewebsites.net/articles/tech/"];
    ArticleService *service = [ArticleService sharedInstance];
    [self measureBlock:^{
        NSSet<ArticleModel *> *result = [service articlesForURL:techSectionUrl error:nil];
        NSLog(@"Loaded %lu articles", (unsigned long)result.count);
    }];
}

@end
