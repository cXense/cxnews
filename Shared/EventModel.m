//
// Created by Anver Bogatov on 04.11.16.
// Copyright (c) 2016 Anver Bogatov. All rights reserved.
//

#import "EventModel.h"

static NSString *kEventName = @"eventName";
static NSString *kPageName = @"pageName";
static NSString *kUrl = @"url";
static NSString *kReferringUrl = @"referringUrl";
static NSString *kTrackerName = @"trackerName";

@implementation EventModel

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.eventName forKey:kEventName];
    [coder encodeObject:self.pageName forKey:kPageName];
    [coder encodeObject:self.url forKey:kUrl];
    [coder encodeObject:self.referringUrl forKey:kReferringUrl];
    [coder encodeObject:self.trackerName forKey:kTrackerName];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.eventName = [coder decodeObjectForKey:kEventName];
        self.pageName = [coder decodeObjectForKey:kPageName];
        self.url = [coder decodeObjectForKey:kUrl];
        self.referringUrl = [coder decodeObjectForKey:kReferringUrl];
        self.trackerName = [coder decodeObjectForKey:kTrackerName];
    }
    return self;
}

- (instancetype)initWithEventName:(NSString *)eventName
                         pageName:(NSString *)pageName
                              url:(NSString *)url
                     referringUrl:(NSString *)referringUrl
                      trackerName:(NSString *)trackerName {
    self = [super init];
    if (self) {
        self.eventName = eventName;
        self.pageName = pageName;
        self.url = url;
        self.referringUrl = referringUrl;
        self.trackerName = trackerName;
    }

    return self;
}

+ (instancetype)modelWithEventName:(NSString *)eventName
                          pageName:(NSString *)pageName
                               url:(NSString *)url
                      referringUrl:(NSString *)referringUrl
                       trackerName:(NSString *)trackerName {
    return [[self alloc] initWithEventName:eventName pageName:pageName url:url referringUrl:referringUrl trackerName:trackerName];
}


@end
