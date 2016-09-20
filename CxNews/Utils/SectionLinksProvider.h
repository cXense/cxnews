//
//  SectionLinksProvider.h
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionLinksProvider : NSObject

/** Get string with URL of provided section */
+(nullable NSString *)urlForSection:(nonnull NSString *)section;

@end
