//
//  InterestsProcessingServiceTests.m
//  CxNews
//
//  Created by Anver Bogatov on 12.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InterestModel.h"
#import "InterestsProcessingService.h"

@interface InterestsProcessingServiceTests : XCTestCase

@end

@implementation InterestsProcessingServiceTests

- (void)testProcessInterestsTreeEmpty {
    NSArray<InterestModel *> *plainInterests = [NSArray array];
    NSArray<InterestModel *> *result = [InterestsProcessingService processInterestsTree:plainInterests];
    XCTAssertNotNil(result);
    XCTAssertEqual(result.count, plainInterests.count);
}

- (void)testProcessInterestsTree {
    NSArray<InterestModel *> *interests = [self interestModels4Test];
    NSArray<InterestModel *> *result = [InterestsProcessingService processInterestsTree:interests];
    XCTAssertNotNil(result);
    XCTAssertEqual(result.count, 7);
}

- (void)testPerformanceExample {
    NSArray<InterestModel *> *interests = [self interestModels4Test];
    [self measureBlock:^{
        [InterestsProcessingService processInterestsTree:interests];
    }];
}

-(NSArray<InterestModel *> *)interestModels4Test {
    return @[
             [[InterestModel alloc] initWithCategory:@"news" andWeight:96.5],
             [[InterestModel alloc] initWithCategory:@"news/life" andWeight:3.5],
             [[InterestModel alloc] initWithCategory:@"news/politics" andWeight:2.0],
             [[InterestModel alloc] initWithCategory:@"news/business" andWeight:1.0],
             [[InterestModel alloc] initWithCategory:@"news/business/companies" andWeight:0.0],
             [[InterestModel alloc] initWithCategory:@"news/business/companies/unsupported" andWeight:0.0],
             [[InterestModel alloc] initWithCategory:@"career" andWeight:96.5],
             [[InterestModel alloc] initWithCategory:@"career/hire" andWeight:3.5],
             [[InterestModel alloc] initWithCategory:@"career/teamwork" andWeight:2.0],
             [[InterestModel alloc] initWithCategory:@"career/opportunity" andWeight:1.0],
             [[InterestModel alloc] initWithCategory:@"technology" andWeight:96.5],
             [[InterestModel alloc] initWithCategory:@"technology/it" andWeight:3.5],
             [[InterestModel alloc] initWithCategory:@"technology/engineering" andWeight:2.0],
             [[InterestModel alloc] initWithCategory:@"technology/computers" andWeight:1.0],
             [[InterestModel alloc] initWithCategory:@"sport" andWeight:96.5],
             [[InterestModel alloc] initWithCategory:@"science" andWeight:96.5],
             [[InterestModel alloc] initWithCategory:@"music" andWeight:96.5],
             [[InterestModel alloc] initWithCategory:@"apple" andWeight:96.5]
             ];
}

@end
