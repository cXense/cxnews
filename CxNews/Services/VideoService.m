//
//  VideoService.m
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "VideoService.h"

@implementation VideoService

-(void)availableVideosWithCompleteion:(VideoServiceCompletion)completion {
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURL *videoSectinUrl = [NSURL URLWithString:@"https://cxnews.azurewebsites.net/videos/videos"];

    NSError *error = nil;
    NSString *fullHtml = [NSString stringWithContentsOfURL:videoSectinUrl
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
    if (error != nil) {
        completion(nil, error);
        return;
    }

    NSRange range = [fullHtml rangeOfString:@"href=\"/Videos/CNN/"];
    

    NSLog(@"%@", fullHtml);
}

+ (instancetype)sharedInstance {
    static VideoService* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VideoService new];
    });
    return instance;
}

@end
