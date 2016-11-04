//
//  InterfaceController.m
//  CxNews
//
//  Created by Anver Bogatov on 01.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "InterfaceController.h"
#import "EventModel.h"
@import WatchConnectivity;

@interface InterfaceController ()

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)tapLikeButton {
    EventModel *event = [EventModel modelWithEventName:@"Apple Watch"
                                              pageName:@"Apple Watch like page"
                                                   url:@"https://apple.watch.ru"
                                          referringUrl:@"http://cxnews.com"
                                           trackerName:@"Watch OS Tracker"];
    NSLog(@"Like button was tapped");
    
    [[WCSession defaultSession] sendMessageData:[NSKeyedArchiver archivedDataWithRootObject:event]
                                   replyHandler:^(NSData *replyMessageData) {
                                       NSLog(@"Hello world");
                                   } errorHandler:^(NSError *error) {
                                       NSLog(@"Error: %@", [error description]);
                                   }];
}

@end



