//
//  ATS-URL-Converter.h
//  CxNews
//
//  Created by Anver Bogatov on 16.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATS_URL_Converter : NSObject

/**
 Converts provided string with non-secured URL (that uses 'http' protocol) to
 secured one (which uses 'https' protocol). Convertation will be performed
 only if it is needed. In case of already URL with 'https' provided
 nothing will be changed.

 @param originalUrl string with non-secured URL

 @return string with URL uses 'https' as protocol
 */
+(NSString *)convertToHttps:(NSString *)originalUrl;

@end
