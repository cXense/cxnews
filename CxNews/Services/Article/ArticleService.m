//
//  ArticleService.m
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "ArticleService.h"
#import "ArticleModel.h"
#import "ArticleLoader.h"
#import "Constants.h"
#import "ATS-URL-Converter.h"

@implementation ArticleService

+ (instancetype)sharedInstance {
    static ArticleService * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void)articleForURL:(nonnull NSURL *)url
          completion:(_Nonnull SoloArticleModelCompletion)completion {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               if (connectionError || !data) {
                                   NSLog(@"Article page load has failed");
                                   completion(nil, connectionError);
                                   return;
                               }

                               NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

                               ArticleModel *model = [[ArticleModel alloc] init];

                               // Preparation for further parsing
                               NSRange range = [html rangeOfString:@"<div class=\"cXenseParse\" style=\"padding: 30px;\">"];
                               if (range.length == NSNotFound) {
                                   NSLog(@"Article data could not be parsed");
                                   return;
                               }
                               NSString *baseDiv = [html substringFromIndex:range.location + range.length];

                               // Section parse logic
                               NSRange sectionRange = [baseDiv rangeOfString:@">"];
                               NSString *sectionTemp = [baseDiv substringFromIndex:sectionRange.location + sectionRange.length];
                               sectionRange = [sectionTemp rangeOfString:@"</div>"];
                               model.section = [sectionTemp substringToIndex:sectionRange.location];

                               // Timestamp parse logic
                               NSRange timestampRange = [baseDiv rangeOfString:@"<div style=\"font-size: 13px; color: #555; font-weight: 300;\">"];
                               NSString *timestampTemp = [baseDiv substringFromIndex:timestampRange.location + timestampRange.length];
                               timestampRange = [timestampTemp rangeOfString:@"</div>"];
                               model.timestamp = [timestampTemp substringToIndex:timestampRange.location];

                               // Content parse logic
                               NSRange contentRange = [baseDiv rangeOfString:@"<div style=\"font-size: 18px; margin-bottom: 30px; padding-bottom: 30px\">"];
                               NSString *contentTemp = [baseDiv substringFromIndex:contentRange.location + contentRange.length];
                               contentRange = [contentTemp rangeOfString:@"</div>"];
                               model.content = [contentTemp substringToIndex:contentRange.location];

                               // Headline parse logic
                               NSRange headlineRange = [baseDiv rangeOfString:@"<div style=\"font-size: 32px; font-weight: 600; line-height: 115%; min-height: 60px; padding: 4px 0 4px 0;\">"];
                               NSString *headlineTemp = [baseDiv substringFromIndex:headlineRange.location + headlineRange.length];
                               headlineRange = [headlineTemp rangeOfString:@"</div>"];
                               model.headline = [headlineTemp substringToIndex:headlineRange.location];

                               // Image parse logic
                               NSRange imageRange = [html rangeOfString:@"<div style=\"max-height: 600px; overflow-y: hidden; position: relative\">"];
                               NSString *imageTemp = [html substringFromIndex:imageRange.location + imageRange.length];
                               imageRange = [imageTemp rangeOfString:@"<img src=\""];
                               imageTemp = [imageTemp substringFromIndex:imageRange.location + imageRange.length];
                               imageRange = [imageTemp rangeOfString:@"<img src=\""];
                               imageTemp = [imageTemp substringFromIndex:imageRange.location + imageRange.length];
                               imageRange = [imageTemp rangeOfString:@"\""];
                               model.imageUrl = [ATS_URL_Converter convertToHttps:[imageTemp substringToIndex:imageRange.location]];

                               // Article Url
                               NSString *securedUrl = [ATS_URL_Converter convertToHttps:url.absoluteString];
                               model.url = securedUrl;
                               model.clickUrl = securedUrl;

                               completion(model, nil);
                           }];
}

-(void)articlesForURL:(nonnull NSURL *)url
           completion:(_Nonnull MultipleArticleModelCompletion)completion {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               if (connectionError) {
                                   NSLog(@"Section page can not be loaded");
                                   completion([NSSet set], connectionError);
                                   return;
                               }

                               NSString *rawHtml = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

                               NSRange sectionRange = [url.absoluteString rangeOfString:kCxenseSiteBaseUrl];
                               NSString *temporary = [url.absoluteString substringFromIndex:sectionRange.location+sectionRange.length];
                               // all articles in 'news' section must be aquaired without section specifier
                               if ([temporary isEqualToString:@"/articles/news/"]) {
                                   temporary = @"/articles/";
                               }

                               NSMutableSet<NSString *> *articleURLs = [NSMutableSet set];

                               NSRange range = [rawHtml rangeOfString:temporary];
                               while (range.location != NSNotFound) {
                                   rawHtml = [rawHtml substringFromIndex:range.location];
                                   NSRange rest = [rawHtml rangeOfString:@"\""];
                                   [articleURLs addObject:[rawHtml substringToIndex:rest.location]];
                                   rawHtml = [rawHtml substringFromIndex:range.location];
                                   range = [rawHtml rangeOfString:temporary];
                               }

                               NSMutableSet<ArticleModel *> *result = [NSMutableSet set];
                               for (NSString *articleUrl in articleURLs) {
                                   NSString *fullArticleUrl = [NSString stringWithFormat:@"%@%@", kCxenseSiteBaseUrl, articleUrl];
                                   NSError *error;
                                   @try {
                                       ArticleModel *article = [self articleForURL:[NSURL URLWithString:fullArticleUrl] error:&error];
                                       if (!error) [result addObject:article];
                                   } @catch (NSException *exception) {
                                       NSLog(@"Cannot extract articles from %@", articleUrl);
                                   }
                               }

                               completion(result, connectionError);
                           }];
}

- (ArticleModel *)articleForURL:(NSURL *)url
                          error:(NSError *__autoreleasing *)error{
    NSHTTPURLResponse *response;
    NSError *er;
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&response error:&er];

    if (er || !data) {
        NSLog(@"Article page load has failed");
        *error = er;
        return nil;
    }

    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    ArticleModel *model = [[ArticleModel alloc] init];

    // Preparation for further parsing
    NSRange range = [html rangeOfString:@"<div class=\"cXenseParse\" style=\"padding: 30px;\">"];
    if (range.length == NSNotFound) {
        NSLog(@"Article data could not be parsed");
        return nil;
    }
    NSString *baseDiv = [html substringFromIndex:range.location + range.length];

    // Section parse logic
    NSRange sectionRange = [baseDiv rangeOfString:@">"];
    NSString *sectionTemp = [baseDiv substringFromIndex:sectionRange.location + sectionRange.length];
    sectionRange = [sectionTemp rangeOfString:@"</div>"];
    model.section = [sectionTemp substringToIndex:sectionRange.location];

    // Timestamp parse logic
    NSRange timestampRange = [baseDiv rangeOfString:@"<div style=\"font-size: 13px; color: #555; font-weight: 300;\">"];
    NSString *timestampTemp = [baseDiv substringFromIndex:timestampRange.location + timestampRange.length];
    timestampRange = [timestampTemp rangeOfString:@"</div>"];
    model.timestamp = [timestampTemp substringToIndex:timestampRange.location];

    // Content parse logic
    NSRange contentRange = [baseDiv rangeOfString:@"<div style=\"font-size: 18px; margin-bottom: 30px; padding-bottom: 30px\">"];
    NSString *contentTemp = [baseDiv substringFromIndex:contentRange.location + contentRange.length];
    contentRange = [contentTemp rangeOfString:@"</div>"];
    model.content = [contentTemp substringToIndex:contentRange.location];

    // Headline parse logic
    NSRange headlineRange = [baseDiv rangeOfString:@"<div style=\"font-size: 32px; font-weight: 600; line-height: 115%; min-height: 60px; padding: 4px 0 4px 0;\">"];
    NSString *headlineTemp = [baseDiv substringFromIndex:headlineRange.location + headlineRange.length];
    headlineRange = [headlineTemp rangeOfString:@"</div>"];
    model.headline = [headlineTemp substringToIndex:headlineRange.location];

    // Image parse logic
    NSRange imageRange = [html rangeOfString:@"<div style=\"max-height: 600px; overflow-y: hidden; position: relative\">"];
    NSString *imageTemp = [html substringFromIndex:imageRange.location + imageRange.length];
    imageRange = [imageTemp rangeOfString:@"<img src=\""];
    imageTemp = [imageTemp substringFromIndex:imageRange.location + imageRange.length];
    imageRange = [imageTemp rangeOfString:@"<img src=\""];
    imageTemp = [imageTemp substringFromIndex:imageRange.location + imageRange.length];
    imageRange = [imageTemp rangeOfString:@"\""];
    model.imageUrl = [ATS_URL_Converter convertToHttps:[imageTemp substringToIndex:imageRange.location]];
    
    // Article Url
    NSString *securedUrl = [ATS_URL_Converter convertToHttps:url.absoluteString];
    model.url = securedUrl;
    model.clickUrl = securedUrl;
    
    return model;
}

#pragma mark - Utility methods
- (id)handleError:(nullable NSError *)error
   withLogMessage:(nonnull NSString *)msg
      returnError:(NSError **)rError {
    NSLog(@"%@: %@", msg, error.description);
    *rError = error;
    return nil;
}

@end
