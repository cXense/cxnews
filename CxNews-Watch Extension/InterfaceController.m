//
//  InterfaceController.m
//  CxNews
//
//  Created by Anver Bogatov on 01.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "InterfaceController.h"
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
    WKAlertAction *action = [WKAlertAction new];
    
//    [self presentAlertControllerWithTitle:@"Notification" message:@"Like button was pressed" preferredStyle:WKAlertControllerStyleAlert actions:[NSArray arrayWithObject:action]];
    
    NSDictionary<NSString *, id>* params = [NSDictionary dictionaryWithObject:@"Value" forKey:@"Key"];
    
    NSLog(@"Like button was tapped");
    
    [[WCSession defaultSession] sendMessage:params replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        NSLog(@"Hello world");
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"Error: %@", [error description]);
    }];
}

@end



