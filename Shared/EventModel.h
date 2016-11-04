//
// Created by Anver Bogatov on 04.11.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventModel : NSObject <NSCoding>

@property NSString *eventName;
@property NSString *pageName;
@property NSString *url;
@property NSString *referringUrl;
@property NSString *trackerName;

- (instancetype)initWithEventName:(NSString *)eventName
                         pageName:(NSString *)pageName
                              url:(NSString *)url
                     referringUrl:(NSString *)referringUrl
                      trackerName:(NSString *)trackerName;

+ (instancetype)modelWithEventName:(NSString *)eventName
                          pageName:(NSString *)pageName
                               url:(NSString *)url
                      referringUrl:(NSString *)referringUrl
                       trackerName:(NSString *)trackerName;


@end