//
//  CXNEventsService.h
//  CxNews
//
//  Created by Anver Bogatov on 26/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation.NSString;

@interface CXNEventsService : NSObject

/**
 Track event with specified parameters.

 @param eventName    name of the event
 @param pageName     name of the page to which event belongs
 @param pageUrl      url of the page
 @param referringUrl url of the page from which we
 @param trackerName  name of the events tracker
 */
-(void)trackEventWithName:(NSString *)eventName
          forPageWithName:(NSString *)pageName
                   andUrl:(NSString *)pageUrl
          andRefferingUrl:(NSString *)referringUrl
        byTrackerWithName:(NSString *)trackerName;

/**
 Track active time for event.

 @param eventName   name of the event
 @param trackerName name of the events tracker
 */
-(void)trackActiveTimeOfEventWithName:(NSString *)eventName
                          trackerName:(NSString *)trackerName;

/**
 Create new service instance.

 @return initialized service instance
 */
+(instancetype)sharedInstance;

@end
