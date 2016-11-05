//
//  NewsDataSourceDelegate.h
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;

/**
 Protocol that define specific stages in NewsStorage lifecycle
 on which implemetor can be subscribed.
 */
@protocol NewsStorageDelegate <NSObject>

@optional

/**
 Invokes after news storage update.
 */
-(void)storageDidUpdate;

@end
