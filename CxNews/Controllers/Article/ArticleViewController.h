//
//  ArticleViewController.h
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import UIKit;

@interface ArticleViewController : UIViewController

/**
 String with URL of the article which must be shown on the screen.
 */
@property (nonatomic, weak) NSString *url;
/**
 String with URL of the article which must be shown on the screen.
 Basically, this URL leads to same page as previous, but without redirects on tracking pages.
 This is needed to have events statistics on plain URLs instead of something like 'http://api.cxense.com/click/...'.
 */
@property (nonatomic, weak) NSString *eventUrl;

@end
