//
//  CXNEventsService.h
//  CxNews
//
//  Created by Anver Bogatov on 26/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXNEventsService : NSObject

-(void)trackEventWithName:(NSString *)eventName
          forPageWithName:(NSString *)pageName
                   andUrl:(NSString *)pageUrl
          andRefferingUrl:(NSString *)referringUrl
        byTrackerWithName:(NSString *)trackerName;

-(void)trackActiveTimeOfEventWithName:(NSString *)eventName
                          trackerName:(NSString *)trackerName;

+(instancetype)sharedInstance;

@end
