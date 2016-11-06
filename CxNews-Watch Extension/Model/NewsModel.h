//
//  NewsModel.h
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Model class that contains only vital information for
 presenting news content on the screen.
 */
@interface NewsModel : NSObject

/**
 News article timestamp.
 */
@property NSString *timestamp;

/**
 News article headline.
 */
@property NSString *headline;

/**
 Create new model of news article with specific data.

 @param timestamp article's timestamp
 @param headline article's headline
 @return initialized model
 */
+(instancetype)newsModelWith:(NSString *)timestamp
                         and:(NSString *)headline;

@end
