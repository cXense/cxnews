//
//  ExtensionDelegate.m
//  CxNews
//
//  Created by Anver Bogatov on 02.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "ExtensionDelegate.h"

@implementation ExtensionDelegate

- (void)sessionDidBecomeInactive:(WCSession *)session {
    NSLog(@"Session become inactive");
}

- (void)sessionDidDeactivate:(WCSession *)session {
    NSLog(@"Session did deactivate");
}

- (void)applicationDidFinishLaunching {
    [self setupWatchConnectivity];
}

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error {
    if (error) {
        NSLog(@"Error happened: %@", [error description]);
        return;
    }
    
    NSLog(@"Activation state: %ld", (long)activationState);
}

#pragma mark WatchConnectivity utils

/**
 Method creates connection with iOS counterpart application if available.
 */
-(void)setupWatchConnectivity {
    if ([WCSession isSupported]) {
        WCSession *wcSession = [WCSession defaultSession];
        wcSession.delegate = self;
        [wcSession activateSession];
    }
}

@end
