//
//  CxenseContentContext.h
//  CxenseContent
//
//  Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CxenseContentContext : NSObject <NSCopying>

/**
 *  The URL
 */
@property (nonatomic, strong) NSString *url;

/**
 *  Specifies/overrides the pageclass of the current page
 */
@property (nonatomic, strong) NSString *pageclass;

/**
 *  Specifies/overrides the sentiment of the current page
 */
@property (nonatomic, strong) NSString *sentiment;

/**
 *  Specifies/overrides the recs-recommending setting of the current page
 */
@property (nonatomic) BOOL recommending;

/**
 *  Specifies/overrides the categories of the current page
 */
@property (nonatomic, strong) NSDictionary *categories;

/**
 *  A list of dynamic keywords describing the context
 */
@property (nonatomic, strong) NSArray *keywords;

/**
 *  A list of article IDs already linked near the widget.
 *  By default we will try to avoid recommending the same articles.
 *  For this to work the articles must be tagged with cXenseParse:recs:articleid
 */
@property (nonatomic, strong) NSArray *neighbors;

/**
 *  The URL of the document that 'linked' to this page
 */
@property (nonatomic, strong) NSString *referrer;

@end
