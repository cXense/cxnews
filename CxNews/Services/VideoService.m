//
//  VideoService.m
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "VideoService.h"
#import "VideoModel.h"

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

    NSMutableSet<VideoModel *> *result = [NSMutableSet set];

    NSString *temp = [NSString stringWithString:fullHtml];
    NSRange range;

    while ((range = [temp rangeOfString:@"/Videos/CNN/"]).location != NSNotFound) {
        temp = [temp substringFromIndex:range.location];
        NSRange urlEnd = [temp rangeOfString:@"\">"];
        NSString *videoUrl = [temp substringToIndex:urlEnd.location];
        temp = [temp substringFromIndex:urlEnd.location + urlEnd.length];

        range = [temp rangeOfString:@"src=\""];
        temp = [temp substringFromIndex:range.location + range.length];
        urlEnd = [temp rangeOfString:@"\""];
        NSString *thumbnailUrl = [temp substringToIndex:urlEnd.location];

        range = [temp rangeOfString:@"font-weight: 300;\">"];
        temp = [temp substringFromIndex:range.location + range.length];
        urlEnd = [temp rangeOfString:@"</"];
        NSString *timestamp = [temp substringToIndex:urlEnd.location];

        range = [temp rangeOfString:@"padding-bottom: 4px;\">"];
        temp = [temp substringFromIndex:range.location + range.length];
        urlEnd = [temp rangeOfString:@"</"];
        NSString *title = [temp substringToIndex:urlEnd.location];

        VideoModel *model = [VideoModel new];
        model.videoPageUrl = [NSString stringWithFormat:@"https://cxnews.azurewebsites.net%@", videoUrl];
        model.imageUrl = thumbnailUrl;
        model.title = title;
        model.timestamp = timestamp;

        [result addObject:model];
    }

    completion(result, nil);
}

-(NSString *)urlWithVideoFromPage:(NSString *)videoPageUrl {
    NSError *error = nil;
    NSString *fullHtml = [NSString stringWithContentsOfURL:[NSURL URLWithString:videoPageUrl]
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
    if (error != nil) {
        NSLog(@"Failure: %@", [error description]);
        return nil;
    }

    NSRange range = [fullHtml rangeOfString:@"<video"];
    NSString *temp = [fullHtml substringFromIndex:range.location+range.length];
    range = [temp rangeOfString:@"src=\""];
    temp = [temp substringFromIndex:range.location+range.length];
    NSRange endRange = [temp rangeOfString:@"\""];
    return [temp substringToIndex:endRange.location];
};

+ (instancetype)sharedInstance {
    static VideoService* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [VideoService new];
    });
    return instance;
}

@end
