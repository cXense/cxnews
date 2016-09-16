//
//  ATS-URL-Converter.m
//  CxNews
//
//  Created by Anver Bogatov on 16.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "ATS-URL-Converter.h"

@implementation ATS_URL_Converter

+(NSString *)convertToHttps:(NSString *)originalUrl {
    return [originalUrl stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"];
}

@end
