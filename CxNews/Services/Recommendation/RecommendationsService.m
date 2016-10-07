//
//  RecommendationsService.m
//  CxNews
//
//  Created by Anver Bogatov on 21.05.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "RecommendationsService.h"
#import "CxenseContent.h"
#import "UserService.h"
#import "Constants.h"

@implementation RecommendationsService

- (void)fetchRecommendationsForUserWithExternalId:(NSString *)externalId
                                     withCallback:(void (^)(BOOL success, NSArray *items, NSError *error))callback {
    /*
     This method is a simple example of working with Cxense Content APIs.
     
     First thing that you should know about Cxense Content is that it operates
     with widgets. Widgets are html templates that can be configured on 'https://content.cxense.com'
     and which will be rendered later on the web page that imports that widget. 
     
     On mobile platforms each widget carries set of content items that can be presented
     by your application's UI. 
     
     Widgets show user specific content, that is why they should be configured properly.
     */

    NSLog(@"Fetching recommendations for user '%@'", externalId);

    /*
     For correct work each widget must have information about user to which it must give content
     recommendations. So, first thing while working with Cxense Content is providing
     information about current user.
     */
    NSString *userExternalId = [[UserService sharedInstance] userExternalId];
    CxenseContentUser *defUser = [CxenseContentUser userWithIds:@{@"usi" : userExternalId, @"cxd" : userExternalId}
                                                          likes:nil
                                                       dislikes:nil];
    [CxenseContent setDefaultUser:defUser];

    /*
     You can configure your widget to show more relevant information to the user's interests.
     That can be done through CxenseContentContext object.
     */
    CxenseContentContext *context = [CxenseContentContext new];
    [context setUrl:kCxenseSiteBaseUrl];

    CxenseContentWidget *widget = [CxenseContent widgetWithId:kCxenseWidgetId
                                                      context:context
                                                         user:defUser];

    /*
     Result content recommendation items can be recieved by using 'fetchItemsWithCompletion:' method.
     Content recommendation items and the widget itself have no UI, so, it is up to you how to present them.
     */
    [widget fetchItemsWithCompletion:callback];
}

@end
