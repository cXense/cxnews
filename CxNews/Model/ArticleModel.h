//
//  ArticleDescriptor.h
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CxenseContentRecommendation;

/**
 * ArticleModel is a simple representation of article and its content.
 */
@interface ArticleModel : NSObject

/** String with URL of article's main image. */
@property NSString *imageUrl;

/** Section of the site to which article belongs. */
@property NSString *section;

/** Article's headline. */
@property NSString *headline;

/** Timestamp of the article. */
@property NSString *timestamp;

/** Article's text content. */
@property NSString *content;

/** Article's URL. */
@property NSString *url;

/** Article's URL specific for content widget. */
@property NSString *clickUrl;

@end
