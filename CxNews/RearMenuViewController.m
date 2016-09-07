//
//  RearMenuViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 28.05.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "UIViewController+Indicator.h"
#import "RearMenuViewController.h"
#import "SWRevealViewController.h"
#import "Constants.h"
#import "CxenseInsight.h"
#import "ArticleService.h"
#import "FeedViewController.h"
#import "SectionLinksProvider.h"

@interface RearMenuViewController ()

@end

@implementation RearMenuViewController {
@private
    __weak IBOutlet UISearchBar *searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // Ignore cell with search bar
        return;
    }

    __kindof UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    __kindof UILabel *menuItemLabel = [cell viewWithTag:kCxenseRearMenuItemTag];

    if ([menuItemLabel.text isEqualToString:@"Recommended"]) {
        FeedViewController *vc = (FeedViewController *) ((UINavigationController *) self.revealViewController.frontViewController).topViewController;
        vc.articles = nil;
        vc.section = menuItemLabel.text;
        [vc updateView];
        [self.revealViewController revealToggle:nil];
    } else {
        NSString *stringUrl = [SectionLinksProvider urlForSection:menuItemLabel.text];
        FeedViewController *vc = (FeedViewController *) ((UINavigationController *) self.revealViewController.frontViewController).topViewController;
        // clean up previous content
        vc.articles = [NSArray array];
        [vc updateView];
        [self.revealViewController revealToggle:nil];
        [self showActivityIndicator];
        // load new content async
        [[ArticleService sharedInstance] articlesForURL:[NSURL URLWithString:stringUrl] completion:^(NSSet<ArticleModel *> *articles, NSError *error) {
            vc.articles = [articles allObjects];
            vc.section = menuItemLabel.text;
            [vc updateView];
            [self dismissActivityIndicator];
        }];
    }

}

#pragma mark - UI Search Bar delegate methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Sorry"
                                                                     message:@"Search is not available yet."
                                                              preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    [alertVC addAction:defaultAction];

    [self presentViewController:alertVC
                       animated:YES
                     completion:nil];
}

@end
