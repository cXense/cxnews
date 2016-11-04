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

@interface NewsStorage : NSObject

@property id<NewsDataSourceDelegate> delegate;

@property(nonatomic, setter=setNews:) NSArray<NewsModel *> *news;

+(instancetype)sharedInstance;

@end
