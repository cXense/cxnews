//
//  SectionLinksProvider.h
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionLinksProvider : NSObject

/**
 Get string with URL of provided section.

 @param section name of CxNews site's section which url must be provided

 @return string with site section's url
 */
+(nullable NSString *)urlForSection:(nonnull NSString *)section;


/**
 Get array of CxNews site sections' urls supported by mobile application.

 @return array with sections' urls
 */
+(nonnull NSArray<NSString *> *)supportedSiteSectionURLs;

@end
