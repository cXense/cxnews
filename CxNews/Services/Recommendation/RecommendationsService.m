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

@implementation RecommendationsService

- (void)fetchRecommendationsForUserWithExternalId:(NSString *)externalId
                                     withCallback:(void (^)(BOOL success, NSArray *items, NSError *error))callback {
    NSLog(@"Fetching recommendations for user '%@'", externalId);
    NSString *userExternalId = [[UserService sharedInstance] userExternalId];
    CxenseContentUser *defUser = [CxenseContentUser userWithIds:@{@"usi" : userExternalId, @"cxd" : userExternalId}
                                                          likes:nil
                                                       dislikes:nil];

    [CxenseContent setDefaultUser:defUser];

    CxenseContentContext *context = [[CxenseContentContext alloc] init];
    [context setUrl:CX_NEWS_URL];

    CxenseContentWidget *widget = [CxenseContent widgetWithId:CXENSE_CONTENT_WIDGET_ID
                                                      context:context
                                                         user:defUser];

    [widget fetchItemsWithCompletion:callback];
}

@end