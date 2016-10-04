//
//  FeedViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 05.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "ArticleViewController.h"
#import "FeedViewController.h"
#import "CxenseContentRecommendation.h"
#import "RecommendationsService.h"
#import "SWRevealViewController.h"
#import "UserService.h"
#import "Constants.h"
#import "CxenseInsight.h"
#import "ArticleModel.h"
#import "Reco2ArticleConverter.h"
#import "CXNEventsService.h"
#import "FeedViewController+InsetsGenerator.h"

@interface FeedViewController ()

/**
 Rear menu button.
 */
@property(weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

/**
 User profile button. (if user is not logged in it shows "Login" text)
 */
@property(weak, nonatomic) IBOutlet UIBarButtonItem *userBarButton;

/**
 Collection view itself which renders feed content.
 */
@property (strong, nonatomic) IBOutlet UICollectionView *ibFeedCollectionView;

@end

@implementation FeedViewController {
    RecommendationsService *_recoService;
    NSMutableDictionary *_imageDataCache;
    UIRefreshControl *_refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _imageDataCache = [NSMutableDictionary dictionary];

    // Setup SWRevealViewController
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    // Configure UICollectionView insets dynamically
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) [self.ibFeedCollectionView collectionViewLayout];
    layout.sectionInset = [FeedViewController calculateEdgeInsets];
    [layout invalidateLayout];

    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self
                        action:@selector(loadData)
              forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    self.collectionView.alwaysBounceVertical = YES;

    // Create new Recommendations Service instance
    _recoService = [[RecommendationsService alloc] init];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[UserService sharedInstance] isUserAuthorized]) {
        self.userBarButton.image = [UIImage imageNamed:@"user"];
        self.userBarButton.title = nil;
    } else {
        self.userBarButton.image = nil;
        self.userBarButton.title = @"Login";
    }

    [[CXNEventsService sharedInstance] trackEventWithName:@"Feed View"
                                          forPageWithName:@"Recommendations"
                                                   andUrl:kCxenseSiteBaseUrl
                                          andRefferingUrl:nil
                                        byTrackerWithName:@"Feed"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[CXNEventsService sharedInstance] trackActiveTimeOfEventWithName:@"Feed View"
                                                          trackerName:@"Feed"];
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.articles.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reco_cell"
                                                                           forIndexPath:indexPath];

    ArticleModel *article = self.articles[(NSUInteger) indexPath.row + 1];

    NSString *urlString = article.imageUrl;
    NSURL *imageUrl = [NSURL URLWithString:urlString];

    UIImageView *thumbnail = [cell viewWithTag:kCxenseFeedViewCollectionViewCellImageTag];

    if ([_imageDataCache valueForKey:urlString] != nil) {
        thumbnail.image = [_imageDataCache valueForKey:urlString];
    } else {
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imageUrl]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *_Nullable response, NSData *_Nullable data, NSError *_Nullable connectionError) {
                                   if (connectionError != nil) {
                                       NSLog(@"Image load for row#%ld has failed", (long) indexPath.row);
                                       return;
                                   }
                                   thumbnail.alpha = 0.0;
                                   UIImage *image = [UIImage imageWithData:data];
                                   thumbnail.image = image;
                                   [UIView animateWithDuration:1.0 animations:^{
                                       thumbnail.alpha = 1.0;
                                   }];
                                   [_imageDataCache setValue:image
                                                      forKey:urlString];
                               }];
    }

    UILabel *section = [cell viewWithTag:kCxenseFeedViewCollectionViewCellBodyTag];
    section.text = article.section;

    UITextView *headline = [cell viewWithTag:kCxenseFeedViewCollectionViewCellTitleTag];
    headline.text = article.headline;

    UILabel *timestamp = [cell viewWithTag:kCxenseFeedViewCollectionViewCellTimestampTag];
    timestamp.text = article.timestamp;

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                     withReuseIdentifier:@"header_view"
                                                                                            forIndexPath:indexPath];

    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && self.articles.count > 0) {
        ArticleModel *article = self.articles[0];

        UIButton *section = [supplementaryView viewWithTag:kCxenseFeedViewCollectionViewSupplementaryCellButtonTag];
        section.layer.cornerRadius = 15.0f;

        [section setTitle:article.section
                 forState:UIControlStateNormal];

        UITextView *textView = [supplementaryView viewWithTag:kCxenseFeedViewCollectionViewSupplementaryCellTitleTag];
        textView.text = article.headline;

        NSString *urlString = article.imageUrl;
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        UIImageView *imageView = [supplementaryView viewWithTag:kCxenseFeedViewCollectionViewSupplementaryCellImageTag];
        if ([_imageDataCache valueForKey:urlString] != nil) {
            imageView.image = [_imageDataCache valueForKey:urlString];
        } else {
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imageUrl]
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *_Nullable response, NSData *_Nullable data, NSError *_Nullable connectionError) {
                                       if (connectionError != nil) {
                                           NSLog(@"Image load for supplementary view has failed");
                                           return;
                                       }

                                       imageView.alpha = 0.0;

                                       UIImage *image = [UIImage imageWithData:data];
                                       imageView.image = image;
                                       [_imageDataCache setValue:image
                                                          forKey:urlString];
                                       [UIView animateWithDuration:1.0 animations:^{
                                           imageView.alpha = 1.0;
                                       }];
                                   }];
        }
        supplementaryView.hidden = NO;
    } else {
        supplementaryView.hidden = YES;
    }

    return supplementaryView;
}

#pragma mark - UICollectionViewDelegate methods

- (void)  collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self presentArticleViewControllerWithURL:self.articles[(NSUInteger) indexPath.row + 1]];
}

#pragma mark - UI events handling methods

- (IBAction)handleUserButtonPressed:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:
                            [[UserService sharedInstance] isUserAuthorized] ? @"user_vc" : @"auth_vc"];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (IBAction)handleUserTapOnHeader:(UITapGestureRecognizer *)sender {
    [self presentArticleViewControllerWithURL:self.articles[(NSUInteger) 0]];
}

#pragma mark - Utility methods

- (void)presentArticleViewControllerWithURL:(ArticleModel *)article {
    ArticleViewController *vc = [[UIStoryboard storyboardWithName:@"Main"
                                                           bundle:nil] instantiateViewControllerWithIdentifier:@"article_vc"];
    vc.eventUrl = article.url;
    vc.url = article.clickUrl;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (void)loadData {
    [self setTitle:self.section];
    if (self.articles == nil) {
        // set recommended articles only if external articles list was not provided
        [_recoService fetchRecommendationsForUserWithExternalId:[[UserService sharedInstance] userExternalId]
                                                   withCallback:^(BOOL success, NSArray *items, NSError *error) {
                                                       if (error) {
                                                           NSLog(@"Can not fetch content recommendations");
                                                       }
                                                       [self setTitle:@"Recommended"];
                                                       self.articles = [Reco2ArticleConverter articlesFromRecommendations:items];
                                                       assert(self.articles.count == items.count);
                                                       [self.collectionView reloadData];

                                                       if (_refreshControl.isRefreshing) {
                                                           [_refreshControl endRefreshing];
                                                       }
                                                   }];
    } else {
        [self.collectionView reloadData];
        if (_refreshControl.isRefreshing) {
            [_refreshControl endRefreshing];
        }
    }
}

-(void)updateView {
    [self loadData];
}

@end
