//
//  NewsStorage.h
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "NewsModel.h"
#import "NewsDataSourceDelegate.h"

@import Foundation;

/**
 Updatable storage that contains news models.
 */
@interface NewsStorage : NSObject

/**
 Storage delegate. If set it will be notified about any state change.
 */
@property id<NewsStorageDelegate> delegate;

/**
 Array of news models that are stored in current storage.
 */
@property(nonatomic, setter=setNews:) NSArray<NewsModel *> *news;

/**
 Initialize and return single instance of the service.
 
 @return service instance
 */
+(instancetype)sharedInstance;

@end
