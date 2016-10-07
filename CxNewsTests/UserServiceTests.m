//
//  UserServiceTests.m
//  CxNews
//
//  Created by Anver Bogatov on 01.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserService.h"
#import "Constants.h"

@interface UserServiceTests : XCTestCase

@end

@implementation UserServiceTests

- (void)tearDown {
    [[UserService sharedInstance] logout];
}

- (void)testSharedInstance {
    UserService *service = [UserService sharedInstance];
    XCTAssertNotNil(service);
    UserService *service2 = [UserService sharedInstance];
    XCTAssertNotNil(service2);
    XCTAssertTrue(service == service2);
}

- (void)testIsUserAuthorized {
    XCTAssertFalse([[UserService sharedInstance] isUserAuthorized]);
}

- (void)testAuthWithLoginAndPassword {
    UserService *userService = [UserService sharedInstance];

    AuthorizationResult result = [userService authWithLogin:@"takashi.kodama@cxense.com"
                                                andPassword:@"extraordinary"];
    XCTAssertTrue(result == 0);
    XCTAssertNotNil([[NSUserDefaults standardUserDefaults] stringForKey:kCxenseExternalUserId]);
    XCTAssertNotNil([[NSUserDefaults standardUserDefaults] stringForKey:kCxenseUserProfileId]);
    XCTAssertNotNil([userService userProfileId]);
    XCTAssertNotNil([userService userExternalId]);
}

- (void)testLogout {
    UserService *userService = [[UserService alloc] init];
    AuthorizationResult result = [userService authWithLogin:@"takashi.kodama@cxense.com"
                                                andPassword:@"extraordinary"];
    XCTAssertTrue(result == OK);
    [userService logout];

    XCTAssertNil([[NSUserDefaults standardUserDefaults] stringForKey:kCxenseExternalUserId]);
    XCTAssertNil([[NSUserDefaults standardUserDefaults] stringForKey:kCxenseUserProfileId]);
    XCTAssertNil([userService userProfileId]);
    XCTAssertNotNil([userService userExternalId]);
}

@end
