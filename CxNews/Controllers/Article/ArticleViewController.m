//
//  ArticleViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 03.07.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "Constants.h"
#import "UIViewController+Indicator.h"
#import "ArticleViewController.h"
#import "ArticleServiceAdapter.h"
#import "ArticleModel.h"
#import "CXNEventsService.h"

@import Social;

@interface ArticleViewController()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UITextView *headlineTextView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

@end

@implementation ArticleViewController

#pragma mark - ViewController's lifecycle methods

-(void)viewDidLoad {
    [super viewDidLoad];

    [self cleanupUI];

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
            self.twitterButton.hidden = NO;
            self.facebookButton.hidden = NO;
        }

        [self dismissActivityIndicator];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CXNEventsService sharedInstance] trackEventWithName:@"Article View"
                                          forPageWithName:self.headlineTextView.text
                                                   andUrl:self.eventUrl
                                          andRefferingUrl:kCxenseSiteBaseUrl
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

-(void)cleanupUI {
    self.sectionLabel.text = @"";
    self.timestampLabel.text = @"";
    self.headlineTextView.text = @"";
    self.contentTextView.text = @"";
    self.twitterButton.hidden = YES;
    self.facebookButton.hidden = YES;
}

-(void)updateHeadlineWithText:(NSString *)headline {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[headline dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                   documentAttributes:nil
                                                   error:nil];

    CGFloat fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kCxenseHeadlineFontSizeIPhone : kCxenseHeadlineFontSizeIPad;

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

    CGFloat fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kCxenseTextContentFontSizeIPhone : kCxenseTextContentFontSizeIPad;

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
    }];
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
