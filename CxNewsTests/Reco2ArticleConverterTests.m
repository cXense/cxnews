//
//  Reco2ArticleConverterTests.m
//  CxNews
//
//  Created by Anver Bogatov on 19/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Reco2ArticleConverter.h"

@interface Reco2ArticleConverterTests : XCTestCase

@end

@implementation Reco2ArticleConverterTests {
    CxenseContentRecommendation *reco;
}

- (void)setUp {
    [super setUp];

    NSMutableArray *body = [NSMutableArray array];
    [body addObject:@"Test section"];
    [body addObject:@"Test timestamp"];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"http://www.example.com/image" forKey:@"dominantthumbnail"];
    [parameters setValue:@"Test Headline" forKey:@"title"];
    [parameters setValue:body forKey:@"body"];
    [parameters setValue:@"http://www.example.com/article" forKey:@"url"];
    [parameters setValue:@"http://api.example.com/article" forKey:@"click_url"];

    reco = [[CxenseContentRecommendation alloc] initWithRecommendationDictionary:parameters];
}

- (void)tearDown {
    [super tearDown];
    reco = nil;
}

- (void)testArticleFromReco {
    ArticleModel *result = [Reco2ArticleConverter articleFromRecommendation:reco];

    XCTAssertNotNil(result);
    XCTAssertEqual(result.imageUrl, [reco data][@"dominantthumbnail"]);
    XCTAssertEqual(result.headline, [reco data][@"title"]);
    XCTAssertEqual(result.clickUrl, reco.clickUrl);
    XCTAssertEqual(result.url, reco.url);
    XCTAssertEqual(result.timestamp, reco.data[@"body"][1]);
    XCTAssertEqual(result.section, reco.data[@"body"][0]);
}

- (void)testArticlesFromRecos {
    NSArray<CxenseContentRecommendation *> *recos = [NSArray arrayWithObject:reco];
    NSArray<ArticleModel *> *result = [Reco2ArticleConverter articlesFromRecommendations:recos];
    XCTAssertNotNil(result);
    XCTAssertEqual(result.count, 1);

    ArticleModel *model = result[0];
    XCTAssertEqual(model.imageUrl, [reco data][@"dominantthumbnail"]);
    XCTAssertEqual(model.headline, [reco data][@"title"]);
    XCTAssertEqual(model.clickUrl, reco.clickUrl);
    XCTAssertEqual(model.url, reco.url);
    XCTAssertEqual(model.timestamp, reco.data[@"body"][1]);
    XCTAssertEqual(model.section, reco.data[@"body"][0]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [Reco2ArticleConverter articleFromRecommendation:reco];
    }];
}

@end
