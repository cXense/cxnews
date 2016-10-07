//
//  SectionLinksProviderTests.m
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SectionLinksProvider.h"
#import "Constants.h"

@interface SectionLinksProviderTests : XCTestCase
@end

@implementation SectionLinksProviderTests {
    NSDictionary<NSString *, NSString *> *_mapping;
}

-(void)setUp {
    // predefined mapping of sections names & expected URLs
    _mapping = @{
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
