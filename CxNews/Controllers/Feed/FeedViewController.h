//
//  FeedViewController.h
//  CxNews
//
//  Created by Anver Bogatov on 05.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleModel;

@interface FeedViewController : UICollectionViewController

@property(strong, nonatomic) NSArray <ArticleModel *> *articles;

@property(strong, nonatomic) NSString *section;


/**
 Make feed view re-render 'articles' array content.
 */
-(void)updateView;

@end
