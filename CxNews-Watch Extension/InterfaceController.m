//
//  InterfaceController.m
//  CxNews
//
//  Created by Anver Bogatov on 01.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "NewsRowController.h"
#import "InterfaceController.h"
#import "EventModel.h"
@import WatchConnectivity;

@interface InterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    
    [self.table setNumberOfRows:5 withRowType:@"NewsRowType"];
    for (int i =0; i<0; i++) {
        NewsRowController *controller = (NewsRowController *) [self.table rowControllerAtIndex:i];
        [controller.timestampLabel setText:[NSString stringWithFormat:@"Row #%d", i]];
        [controller.headlineLabel setText:@"Headline"];
    }
    
    // Send event to Cxense Insight through WatchConnectivity
    EventModel *event = [EventModel modelWithEventName:@"CxNews feed opened on Apple Watch"
                                              pageName:@"Apple Watch news feed"
                                                   url:@"http://cxnews.azurewebsites.net"
                                          referringUrl:@"http://cxnews.azurewebsites.net"
                                           trackerName:@"Watch OS Tracker"];
    
    
    /*
     These lines show you how to send custom objects from Watch Extension to iOS counterpart.
     
     Pay attention that we are using here so called 'Interactive Messaging'. That means that data
     will be send and received by iOS counterpart ONLY if watchOS and iOS parts will be active.
     
     iOS counterpart can recieve the message only in class that implements WCSessionDelegate protocol.
     In CxNews application such class is AppDelegate.
     */
    [[WCSession defaultSession] sendMessageData:[NSKeyedArchiver archivedDataWithRootObject:event]
                                   replyHandler:^(NSData *replyMessageData) {
                                       NSLog(@"Message was sent.");
                                   } errorHandler:^(NSError *error) {
                                       NSLog(@"Error: %@", [error description]);
                                   }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



