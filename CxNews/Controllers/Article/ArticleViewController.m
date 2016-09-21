//
//  ArticleViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "Constants.h"
#import "UIViewController+Indicator.h"
#import "CxenseInsight.h"
#import "ArticleViewController.h"
#import "ArticleServiceAdapter.h"

#import "CXNEventsService.h"

#import <Social/Social.h>

@interface ArticleViewController()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ArticleViewController

#pragma mark - ViewController's lifecycle methods

-(void)viewDidLoad {
    [super viewDidLoad];

    [self showActivityIndicator];
    [[ArticleServiceAdapter sharedInstance] articleForURL:[NSURL URLWithString:self.url]completion:^(ArticleModel *model, NSError *error) {
        if (error || !model) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:@"Article could not be loaded due to some error."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [self dismissViewControllerAnimated:YES completion:nil];
                                                                  }];
            [alertVC addAction:defaultAction];

            [self presentViewController:alertVC
                               animated:YES
                             completion:nil];
        } else {
            [self updateArticleImageFromURL:[NSURL URLWithString:model.imageUrl]];
            [self updateContentWithText:model.content];
            [self updateHeadlineWithText:model.headline];

            self.sectionLabel.text = model.section;
            self.timestampLabel.text = model.timestamp;
        }

        [self dismissActivityIndicator];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CXNEventsService sharedInstance] trackEventWithName:@"Article View"
                                          forPageWithName:self.headlineTextView.text
                                                   andUrl:self.eventUrl
                                          andRefferingUrl:@"http://cxnews.azurewebsites.net"
                                        byTrackerWithName:@"Article"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[CXNEventsService sharedInstance] trackActiveTimeOfEventWithName:@"Article View"
                                                          trackerName:@"Article"];
}

#pragma mark - UI events handlers
- (IBAction)handleTweetTap:(UIButton *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        [self shareLink:self.eventUrl bySocialService:SLServiceTypeTwitter];
    } else {
        [self showAlertControllerWithMessage:@"Could not find configured Twitter account."];
    }
}

- (IBAction)handleFacebookTap:(UIButton *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        [self shareLink:self.eventUrl bySocialService:SLServiceTypeFacebook];
    } else {
        [self showAlertControllerWithMessage:@"Could not find configured Facebook account."];
    }
}

#pragma mark - UI components setup

-(void)updateHeadlineWithText:(NSString *)headline {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[headline dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                   documentAttributes:nil
                                                   error:nil];

    float fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kCxenseHeadlineFontSizeIPhone : kCxenseHeadlineFontSizeIPad;

    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"Helvetica Bold" size:fontSize]
                             range:NSMakeRange(0, attributedString.string.length)];

    self.headlineTextView.attributedText = attributedString;
    [self.headlineTextView sizeToFit];
}

-(void)updateContentWithText:(NSString *)contentText {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[contentText dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                   documentAttributes:nil
                                                   error:nil];

    // Add fake text to article content's tail. This is needed only to have article that is looks like real (because of insufficient of real text).
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:kCxenseFakeTextContent]];

    float fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kCxenseTextContentFontSizeIPhone : kCxenseTextContentFontSizeIPad;

    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"Helvetica" size:fontSize]
                             range:NSMakeRange(0, attributedString.string.length)];

    self.contentTextView.attributedText = attributedString;
    [self.contentTextView sizeToFit];
}

-(void)updateArticleImageFromURL:(NSURL *)url {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError != nil) {
            NSLog(@"Error during article image load");
            return;
        }

        self.imageView.alpha = 0.0;

        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
        [UIView animateWithDuration:1.0 animations:^{
            self.imageView.alpha = 1.0;
        }];

        [self updateScrollViewContentSize];

        CGFloat multiplier = CGRectGetWidth(self.imageView.bounds) / image.size.width;
        [self.imageViewHeightConstraint setConstant:multiplier * image.size.height];
    }];
}

-(void)updateScrollViewContentSize {
    CGRect contentRect = CGRectZero;
    for (UIView *subview in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                             contentRect.size.height <= self.view.frame.size.height ? self.view.frame.size.height + 20 : contentRect.size.height);
}

#pragma mark - Util methods

-(void)showAlertControllerWithMessage:(NSString *)message {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"Error"
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                          }];
    [vc addAction:defaultAction];
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

#pragma mark - Social share
-(void)shareLink:(NSString *) url
 bySocialService:(NSString *)serviceType {
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    [vc setInitialText:@"Look what I've found"];
    [vc addURL:[NSURL URLWithString:url]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
