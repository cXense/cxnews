//
//  AppDelegate.m
//  CxNews
//
//  Created by Anver Bogatov on 21.05.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "AppDelegate.h"
#import "UserService.h"
#import "CxenseDMP.h"
#import "CxenseInsight.h"
#import "ArticleServiceAdapter.h"
#import "UserProfileService.h"

@import HockeySDK;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Application '%@' has been launched with options = '%@'", [application description], [launchOptions description]);

    NSString *pathToConfig = [[NSBundle mainBundle] pathForResource:@"private_conf" ofType:@"plist"];
    NSDictionary *privateConfig = [NSDictionary dictionaryWithContentsOfFile:pathToConfig];

    // HockeyApp SDK initialization
    BITHockeyManager *hockeyManager = [BITHockeyManager sharedHockeyManager];
    [hockeyManager configureWithIdentifier:privateConfig[@"HOCKEY_API_KEY"]];
    [hockeyManager.crashManager setCrashManagerStatus:BITCrashManagerStatusAutoSend];
    [hockeyManager startManager];
    [hockeyManager.authenticator authenticateInstallation];

    // Cxense DMP SDK initialization
    [CxenseDMP setUsername:privateConfig[@"CXENSE_API_USERNAME"]
                    apiKey:privateConfig[@"CXENSE_API_KEY"]];

    // Cxense Insight SDK initialization
    [CxenseInsight setDispatchMode:CxenseInsightDispatchModeOnline];

    // Pre-fetch user data if logged in
    if ([[UserService sharedInstance] isUserAuthorized]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UserProfileService *userDataService = [UserProfileService sharedInstance];
            // this operation initializes cache with user data
            [userDataService dataForUserWithExternalId:[[UserService sharedInstance] userExternalId]];
        }];
    }

    // Calculate root view controller
    NSString *rootViewControllerId = nil;
    if ([[UserService sharedInstance] isUserAuthorized]) {
        rootViewControllerId = @"revealViewController";
    } else {
        rootViewControllerId = @"auth_vc";
    }
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main"
                                                                bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:rootViewControllerId];

    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[ArticleServiceAdapter sharedInstance] clear];
}

@end
