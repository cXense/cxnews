//
//  FeedViewController.h
//  CxNews
//
//  Created by Anver Bogatov on 05.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import UIKit;
@class ArticleModel;

/**
 FeedViewController is responsible for showing list of article models
 on screen.
 */
@interface FeedViewController : UICollectionViewController

/**
 List of article models that must be presented on screen.
 */
@property(strong, nonatomic) NSArray <ArticleModel *> *articles;


/**
 Name of the section to which presented article models belongs.
 */
@property(strong, nonatomic) NSString *section;


/**
 Make feed view re-render 'articles' array content.
 */
-(void)updateView;

@end
