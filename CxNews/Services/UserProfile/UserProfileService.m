//
// Created by Anver Bogatov on 07.06.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

#import "UserProfileService.h"
#import "UserModel.h"
#import "InterestModel.h"
#import "CxenseDMP.h"
#import "InterestsProcessingService.h"
#import "Constants.h"

@implementation UserProfileService {
    NSMutableDictionary<NSString *, UserModel *> *dataCache;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        dataCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (UserModel *)dataForUserWithExternalId:(NSString *)externalId {
    UserModel *userData = [dataCache valueForKey:externalId];
    if (userData) {
        NSLog(@"Loading user data from cache");
        return userData;
    }

    NSURL *userProfileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?rnd=%lu",
                                                  kCxenseCrmBaseUrl,
                                                  externalId,
                                                  (NSUInteger) [[NSDate date] timeIntervalSince1970]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:userProfileUrl];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error) {
        NSLog(@"Problems while receiving user data: %@", [error description]);
        return nil;
    }

    NSString *userPageHtml = [[NSString alloc] initWithData:data
                                                   encoding:NSUTF8StringEncoding];
    userData = [UserModel new];
    userData.name = [self userNameFromHtml:userPageHtml];
    userData.email = [self userEmailFromHtml:userPageHtml];
    userData.gender = [self userGenderFromHtml:userPageHtml];
    userData.birthYear = [self userBirthDayFromHtml:userPageHtml];
    userData.location = [self userLocationFromHtml:userPageHtml];
    userData.avatarUrl = [self avatarUrlFromHtml:userPageHtml];
    userData.externalId = externalId;

    [dataCache setObject:userData forKey:externalId];

    return userData;
}

- (void)loadInterestsForUserWithExternalId:(NSString *)externalId
                            withCompletion:(void (^)(NSArray<InterestModel *> *))completion {
    [CxenseDMP getUserProfileWithUserId:externalId
                         identifierType:@"cx"
                             completion:^(CxenseDMPUser *user, NSError *error) {
                                 if (error) {
                                     NSLog(@"Interests profile load failed with %@", error.description);
                                 }

                                 NSMutableArray<InterestModel *> *result = [NSMutableArray array];
                                 for (id obj in [user profiles]) {
                                     CxenseDMPProfile *profile = (CxenseDMPProfile *) obj;
                                     for (id obj in profile.groups) {
                                         CxenseDMPGroup *group = (CxenseDMPGroup *)obj;
                                         if ([group.group isEqualToString:@"cxd-categories"]) {
                                             NSLog(@"Found interest: '%@' = '%f'", profile.item, group.weight);
                                             [result addObject:[[InterestModel alloc] initWithCategory:profile.item andWeight:group.weight * 100]];
                                         }
                                     }
                                 }
                                 completion([InterestsProcessingService processInterestsTree:result]);
                             }];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t token;
    static UserProfileService *instance = nil;
    dispatch_once(&token, ^() {
        instance = [UserProfileService new];
    });
    return instance;
}

#pragma MARK: Utility methods

- (NSString *)userNameFromHtml:(NSString *)html {
    NSRange range = [html rangeOfString:@"<h2 style=\"margin-bottom: 20px;\">"];
    NSString *temp = [html substringFromIndex:range.location + range.length];
    range = [temp rangeOfString:@"</h2>"];
    return [[temp substringToIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet nonBaseCharacterSet]];
}

- (NSString *)userBirthDayFromHtml:(NSString *)html {
    return [self valueOfField:@"BirthYear"
                       inHtml:html];
}

- (NSString *)userGenderFromHtml:(NSString *)html {
    return [self valueOfField:@"Gender"
                       inHtml:html];
}

- (NSString *)userEmailFromHtml:(NSString *)html {
    return [self valueOfField:@"Email"
                       inHtml:html];
}

- (NSString *)userLocationFromHtml:(NSString *)html {
    return [self valueOfField:@"Location"
                       inHtml:html];
}

- (NSString *)avatarUrlFromHtml:(NSString *)html {
    NSRange range = [html rangeOfString:@"<img src=\""];
    NSString *temp = [html substringFromIndex:range.location + range.length];
    range = [temp rangeOfString:@"\""];
    return [temp substringToIndex:range.location];
}

- (NSString *)valueOfField:(NSString *)field
                    inHtml:(NSString *)html {
    NSRange range = [html rangeOfString:field];
    NSString *temp = [html substringFromIndex:range.location + range.length];

    range = [temp rangeOfString:@"\">"];
    temp = [temp substringFromIndex:range.location + range.length];

    range = [temp rangeOfString:@"</div>"];
    temp = [temp substringToIndex:range.location];
    return [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
