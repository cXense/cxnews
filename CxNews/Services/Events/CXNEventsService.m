//
//  CXNEventsService.m
//  CxNews
//
//  Created by Anver Bogatov on 26/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "CXNEventsService.h"
#import "Constants.h"

@import CxenseSDK;

@implementation CXNEventsService {
    NSString *_applicationName;
    NSString *_applicationVersion;
}

- (instancetype)init {
    if (self = [super init]) {
        NSDictionary<NSString *, id> *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        _applicationName = [infoDictionary objectForKey:@"CFBundleName"];
        _applicationVersion = [NSString stringWithFormat:@"%@.%@",
                                                         [infoDictionary objectForKey:@"CFBundleShortVersionString"],
                                                         [infoDictionary objectForKey:@"CFBundleVersion"]];
    }
    return self;
}

- (void)trackEvent:(EventModel *)event {
    [self trackEventWithName:event.eventName
             forPageWithName:event.pageName
                      andUrl:event.url
             andRefferingUrl:event.referringUrl
           byTrackerWithName:event.trackerName];
}

- (void)trackEventWithName:(NSString *)eventName
           forPageWithName:(NSString *)pageName
                    andUrl:(NSString *)pageUrl
           andRefferingUrl:(NSString *)referringUrl
         byTrackerWithName:(NSString *)trackerName {
    /*
     Cxense Insight is powerful and flexible engine for gathering and reporting on custom events.
     
     Cxense SDK also operates with events. Event are list of parameters related to
     certain moment of time or session. They can be built by using one of the provided
     classes - PageViewEvent or PerformanceEvent.
     */
    PageViewEvent *event = [[PageViewEvent alloc] initWithName:eventName];
    
    /*
     Following code demonstrates one of best practises of working with events custom parameters.
     We are tracking here two vital parameters:
     - Name of the application produced an impression
     - Full version (major version + build number) of the application produced an impression
     As soon as events with these custom parameters will be sended to API, Cxense Insight web-app
     will show you statistics on your applications & their versions. This can be important if you have
     multiple applications & version accessing same resources.
     */
    [event addCustomParameterForKey:@"cxn_app" withValue:_applicationName];
    [event addCustomParameterForKey:@"cxn_appv" withValue:_applicationVersion];
    
    /*
     Even if Cxense SDK's API does not provide dedicated method to set certain parameter, you can still
     add it to event's data. For doing that you must consult with event's data reference: https://wiki.cxense.com/display/cust/Event+data
     in attempt to find exact name of paramter you want to attach to event. And then - you must use
     following method.
     */
    [event addParameterForKey:@"pgn" withValue:pageName];
    
    event.location = pageUrl;
    
    /*
     Following method reports your event to Cxense SDK's dispatch engine.
     */
    [Cxense reportEvent:event];
}

- (void)trackActiveTimeOfEventWithName:(NSString *)eventName
                           trackerName:(NSString *)trackerName {
    /*
     Cxense SDK allows tracking active time for any event that was reported earlier by using
     'trackActiveTimeForEvent:' method.
     */
    [Cxense trackActiveTimeForEvent:eventName];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CXNEventsService *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[CXNEventsService alloc] init];
    });
    return instance;
}

@end
