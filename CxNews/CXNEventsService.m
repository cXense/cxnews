//
//  CXNEventsService.m
//  CxNews
//
//  Created by Anver Bogatov on 26/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "CXNEventsService.h"
#import "CxenseInsight.h"
#import "Constants.h"

@implementation CXNEventsService

-(void)trackEventWithName:(NSString *)eventName
          forPageWithName:(NSString *)pageName
                   andUrl:(NSString *)pageUrl
          andRefferingUrl:(NSString *)referringUrl
        byTrackerWithName:(NSString *)trackerName {
    CxenseInsightEventBuilder *builder = [CxenseInsightEventBuilder pageViewEventWithURL:pageUrl referringURL:referringUrl];
    [builder setParameter:pageName
                   forKey:@"pgn"];
    [[CxenseInsight trackerWithName:trackerName
                             siteId:kCxenseInsightSiteId] trackEvent:[builder build] name:eventName completion:^(NSDictionary *event, NSError *error) {
        if (error != nil) {
            NSLog(@"Event for url '%@' was not send because '%@'", pageUrl, error.description);
        }
    }];
}

-(void)trackActiveTimeOfEventWithName:(NSString *)eventName
                          trackerName:(NSString *)trackerName {
    [[CxenseInsight trackerWithName:trackerName
                             siteId:kCxenseInsightSiteId] trackActiveTimeForEvent:eventName];
}

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CXNEventsService *instance;
    dispatch_once(&onceToken, ^{
        instance = [[CXNEventsService alloc] init];
    });
    return instance;
}

@end
