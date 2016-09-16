//
//  SectionLinksProviderTests.m
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SectionLinksProvider.h"

@interface SectionLinksProviderTests : XCTestCase
@end

@implementation SectionLinksProviderTests {
    NSDictionary<NSString *, NSString *> *_mapping;
}

-(void)setUp {
    // predefined mapping of sections names & expected URLs
    _mapping = @{
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
}

-(void)testMappingCorrectness {
    [_mapping enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull expectedUrl, BOOL * _Nonnull stop) {
        NSString *actualUrl = [SectionLinksProvider urlForSection:key];
        XCTAssertTrue([actualUrl isEqualToString:expectedUrl]);
    }];
}

-(void)testNotAvailableValue {
    NSString *actualUrl = [SectionLinksProvider urlForSection:@"Not existent section"];
    XCTAssertNil(actualUrl);
}


@end
