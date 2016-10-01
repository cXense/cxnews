//
// Created by Anver Bogatov on 28.05.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

@import UIKit;
@import AdSupport;

#import "UserService.h"
#import "Constants.h"

@implementation UserService {
    NSString *_userExternalId;
    NSString *_userProfileId;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _userExternalId = [[NSUserDefaults standardUserDefaults] stringForKey:kCxenseExternalUserId];
        _userProfileId = [[NSUserDefaults standardUserDefaults] stringForKey:kCxenseUserProfileId];
    }
    return self;
}


- (void)logout {
    _userExternalId = nil;
    _userProfileId = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCxenseExternalUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCxenseUserProfileId];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

+ (instancetype)sharedInstance {
    static UserService *sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (NSString *)userExternalId {
    return _userExternalId != nil ? _userExternalId : [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

- (NSString *)userProfileId {
    return _userProfileId;
}

- (BOOL)isUserAuthorized {
    return _userProfileId != nil && _userExternalId != nil;
}

- (AuthorizationResult)authWithLogin:(NSString *)login
                         andPassword:(NSString *)password {
    if ([self isUserAuthorized]) {
        return AlreadyLoggedIn;
    }

    /*
     Following lines of code just a continuation of workaround of API absense. After cookie storage was initialized in a very firts view controller
     */
    NSHTTPCookie *userIdCookie = nil;
    // 0. Preparation
    for (NSHTTPCookie *obj in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://cxnews.azurewebsites.net"]]) {
        if ([obj.name isEqualToString:@"cX_P"]) {
            userIdCookie = obj;
        }
    }

    // 1. We should get 'RequestVerificationToken' from login page
    NSString *loginPageUrl = @"http://cxnews.azurewebsites.net/Account/Login?ReturnUrl=%2F";
    NSURL *verificationURL = [NSURL URLWithString:loginPageUrl];
    NSURLRequest *requestLoginPage = [NSURLRequest requestWithURL:verificationURL];

    NSHTTPURLResponse *loginPageResponse = nil;
    NSError *loginPageError = nil;

    NSData *data = [NSURLConnection sendSynchronousRequest:requestLoginPage
                                         returningResponse:&loginPageResponse
                                                     error:&loginPageError];

    // Please close your eyes - some raw HTML parsing over here...
    // dumb logic for searching '__RequestVerificationToken' of login form
    NSString *loginFormHtml = [[NSString alloc] initWithData:data
                                                    encoding:NSUTF8StringEncoding];
    NSString *formVerificationToken = [self verificationTokenFromHtml:loginFormHtml];


    NSDictionary *dictionary = [loginPageResponse allHeaderFields];

    NSArray<NSHTTPCookie *> *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:dictionary
                                                                              forURL:verificationURL];

    NSHTTPCookie *verificationCookie = nil;
    NSHTTPCookie *dotNetCookie = nil;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.name isEqualToString:@"__RequestVerificationToken"]) {
            verificationCookie = cookie;
        } else if ([cookie.name isEqualToString:@"ARRAffinity"]) {
            dotNetCookie = cookie;
        }
    }

    NSLog(@"Checkpoint. Verification cookie: '%@'", verificationCookie);

    // 2. Execute POST request to CxNews
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginPageUrl]];

    request.HTTPMethod = @"POST";

    NSString *stringData = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",
                            @"__RequestVerificationToken",
                            formVerificationToken,
                            @"UserName",
                            login,
                            @"Password",
                            password,
                            @"RememberMe",
                            @"false"];
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;

    [request setValue:@"http://cxnews.azurewebsites.net"
   forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://cxnews.azurewebsites.net/Account/Login"
   forHTTPHeaderField:@"Referer"];
    [request setValue:@"1"
   forHTTPHeaderField:@"Upgrade-Insecure-Requests"];

    NSHTTPURLResponse *res = nil;
    NSError *error = nil;

    // response is ignored because this invocation was needed only to store cookies that are result of auth process
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&res
                                      error:&error];

    NSURLResponse *profileResponse = nil;
    NSError *profileError = nil;

    NSURL *profileInterestURL = [[NSURL alloc] initWithString:@"http://cxnews.azurewebsites.net/profileinterests"];
    NSMutableURLRequest *profileInterestRequest = [NSMutableURLRequest requestWithURL:profileInterestURL];
    [profileInterestRequest setValue:@"1"
                  forHTTPHeaderField:@"Upgrade-Insecure-Requests"];

    NSString *cookieString = [NSString stringWithFormat:@"%@=%@; %@=%@; %@=%@;",
                              dotNetCookie.name, dotNetCookie.value,
                              verificationCookie.name, verificationCookie.value,
                              userIdCookie.name, userIdCookie.value];
    [profileInterestRequest addValue:cookieString
                  forHTTPHeaderField:@"Cookie"];

    NSData *profileData = [NSURLConnection sendSynchronousRequest:profileInterestRequest
                                                returningResponse:&profileResponse
                                                            error:&profileError];

    NSString *profileInterestPage = [[NSString alloc] initWithData:profileData
                                                          encoding:NSUTF8StringEncoding];

    NSRange range2 = [profileInterestPage rangeOfString:@"CXENSE USER PROFILE ID"];

    if (range2.location == NSNotFound) {
        NSLog(@"Cannot parse Cxense User Profile Id");
        return Failed;
    }

    NSString *tempString2 = [profileInterestPage substringFromIndex:(range2.location + range2.length)];

    range2 = [tempString2 rangeOfString:@"\">"];
    tempString2 = [tempString2 substringFromIndex:(range2.location + range2.length)];

    range2 = [tempString2 rangeOfString:@"</div>"];
    tempString2 = [tempString2 substringToIndex:range2.location];

    NSLog(@"CXENSE USER PROFILE ID: %@", tempString2);


    NSRange range3 = [profileInterestPage rangeOfString:@"EXTERNAL USER ID"];
    if (range3.location == NSNotFound) {
        NSLog(@"Cannot parse External User Id");
        return Failed;
    }
    NSString *tempString3 = [profileInterestPage substringFromIndex:(range3.location + range3.length)];

    range3 = [tempString3 rangeOfString:@"\">"];
    tempString3 = [tempString3 substringFromIndex:(range3.location + range3.length)];

    range3 = [tempString3 rangeOfString:@"</div>"];
    tempString3 = [tempString3 substringToIndex:range3.location];

    NSLog(@"EXTERNAL USER ID: %@", tempString3);

    _userProfileId = tempString2;
    _userExternalId = tempString3;
    [[NSUserDefaults standardUserDefaults] setValue:_userProfileId
                                             forKey:kCxenseUserProfileId];
    [[NSUserDefaults standardUserDefaults] setValue:_userExternalId
                                             forKey:kCxenseExternalUserId];

    return (tempString2 != nil && [tempString2 length] > 0 && tempString3 != nil && [tempString3 length] > 0) ? OK : Failed;
}

- (NSString *)verificationTokenFromHtml:(NSString *)loginHtml {
    NSRange range = [loginHtml rangeOfString:@"__RequestVerificationToken\""];

    NSString *tempString = [loginHtml substringFromIndex:(range.location + range.length)];
    range = [tempString rangeOfString:@"value=\""];
    tempString = [tempString substringFromIndex:(range.location + range.length)];
    range = [tempString rangeOfString:@"\""];
    
    NSString *formVerificationToken = [tempString substringToIndex:range.location];
    return formVerificationToken;
}
@end
