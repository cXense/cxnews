//
//  AppDelegate.m
//  CxNews
//
//  Created by Anver Bogatov on 21.05.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "AppDelegate.h"
#import "UserService.h"
#import "ArticleServiceAdapter.h"
#import "UserProfileService.h"
#import "CXNEventsService.h"

@import CxenseSDK;
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
    
    // Cxense SDK initialization
    Configuration *config = [[Configuration alloc] initWithUserName:privateConfig[@"CXENSE_API_USERNAME"] apiKey:privateConfig[@"CXENSE_API_KEY"]];
    config.dispatchMode = DispatchModeOnline;
    [Cxense initializeWithConfiguration:config error:nil];
    
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
    
    [self setupWatchConnectivity];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[ArticleServiceAdapter sharedInstance] clear];
}

#pragma mark - WatchConnectivity delegate

- (void)sessionDidBecomeInactive:(WCSession *)session {
    NSLog(@"Session become inactive");
}

- (void)sessionDidDeactivate:(WCSession *)session {
    NSLog(@"Session did deactive");
}

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    if (error) {
        NSLog(@"Error happened: %@", [error description]);
        return;
    }
    NSLog(@"Activation state: %ld", (long) activationState);
}

/*
 That method is responsible for receving messages from watchOS counterpart. 
 Since EventModel implements NSCodying protocol it transmitted in form of NSData.
 */
-(void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData
  replyHandler:(void (^)(NSData * _Nonnull))replyHandler {
    NSLog(@"Message came");
    EventModel *event = (EventModel *) [NSKeyedUnarchiver unarchiveObjectWithData:messageData];
    if (event) {
        [[CXNEventsService sharedInstance] trackEvent:event];
    } else {
        NSLog(@"Event was not sent");
    }
}

#pragma mark WatchConnectivity utils

/**
 Method creates connection with watchOS counterpart application if available.
 */
- (void)setupWatchConnectivity {
    NSLog(@"WC setup started");
    if ([WCSession isSupported]) {
        NSLog(@"WC is supported");
        WCSession *wcSession = [WCSession defaultSession];
        wcSession.delegate = self;
        [wcSession activateSession];
    }
}

@end
