//
//  UserDataServiceTests.m
//  CxNews
//
//  Created by Anver Bogatov on 07.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserProfileService.h"
#import "UserModel.h"

@interface UserDataServiceTests : XCTestCase

@end

@implementation UserDataServiceTests

- (void)testSharedInstance {
    UserProfileService *instance = [UserProfileService sharedInstance];
    XCTAssertNotNil(instance);
    XCTAssertEqual(instance, [UserProfileService sharedInstance]);
}

- (void)testDataForUser {
    /*
     * Writing unit tests with cases related to network activity it's quite
     * bad practise, but I need to be sure that our data load logic works fine,
     * since underlying internals contains raw html parsing.
     */
    UserProfileService *instance = [UserProfileService sharedInstance];
    UserModel *data = [instance dataForUserWithExternalId:@"CRM1000000009"];
    XCTAssertNotNil(data);
    XCTAssertTrue([data.name isEqualToString:@"Jan Helge Sagefl&#229;t"]);
    XCTAssertTrue([data.location isEqualToString:@"Nydalen"]);
    XCTAssertTrue([data.email isEqualToString:@"jan.sageflaat@cxense.com"]);
    XCTAssertTrue([data.birthYear isEqualToString:@"1970"]);
    XCTAssertTrue([data.externalId isEqualToString:@"CRM1000000009"]);
    XCTAssertTrue([data.avatarUrl isEqualToString:@"https://www.cxense.com/wp-content/uploads/2015/05/jan-helge-sageflat-300x300.jpg"]);
    XCTAssertTrue([data.gender isEqualToString:@"Male"]);
}
@end
