//
//  ExtensionDelegate.m
//  CxNews
//
//  Created by Anver Bogatov on 02.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "ExtensionDelegate.h"
#import "NewsModel.h"
#import "NewsStorage.h"

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

- (void) session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSArray<NSString *> *news = (NSArray<NSString *> *) applicationContext[@"articles"];
    if (news) {
        NSLog(@"%d new news were sent", [news count]);
        
        NSMutableArray<NewsModel *> *newNews = [NSMutableArray arrayWithCapacity:([news count] / 2)];
        for (int i = 0; i < [news count]; i += 2) {
            NSString *timestamp = news[i];
            NSString *headline = news[i+1];
            [newNews addObject:[NewsModel newsModelWith:timestamp and:headline]];
        }
        [NewsStorage sharedInstance].news = newNews;
    } else {
        NSLog(@"No new news were sent");
    }
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
