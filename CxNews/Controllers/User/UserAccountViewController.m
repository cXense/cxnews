//
//  UserAccountViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 05.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "UIViewController+Indicator.h"
#import "UserAccountViewController.h"
#import "UserService.h"
#import "UserProfileService.h"
#import "UserModel.h"
#import "CXNEventsService.h"
#import "Constants.h"

@interface UserAccountViewController()

@property(weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(weak, nonatomic) IBOutlet UILabel *labelName;
@property(weak, nonatomic) IBOutlet UILabel *labelEmail;
@property(weak, nonatomic) IBOutlet UILabel *labelGender;
@property(weak, nonatomic) IBOutlet UILabel *labelBirthYear;
@property(weak, nonatomic) IBOutlet UILabel *labelExternalId;
@property(weak, nonatomic) IBOutlet UILabel *labelLocation;

@property(weak, nonatomic) IBOutlet UIImageView *rearAvatar;
@property(weak, nonatomic) IBOutlet UIImageView *frontAvatar;

- (IBAction)handleLogout:(UIButton *)sender;


@end

@implementation UserAccountViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showActivityIndicator];
    UserProfileService *userDataService = [UserProfileService sharedInstance];
    UserModel *userData = [userDataService dataForUserWithExternalId:[[UserService sharedInstance] userExternalId]];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[userData.name dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                   documentAttributes:nil
                                                   error:nil];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]
                             range:NSRangeFromString(userData.name)];

    self.labelName.text = attributedString.string;
    self.labelEmail.text = userData.email;
    self.labelGender.text = userData.gender;
    self.labelBirthYear.text = userData.birthYear;
    self.labelExternalId.text = userData.externalId;
    self.labelLocation.text = userData.location;

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:userData.avatarUrl]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   if (error.code == -1002) {
                                       self.frontAvatar.image = [UIImage imageNamed:@"anonymus"];
                                       [self dismissActivityIndicator];
                                   } else {
                                       NSLog(@"Unable to load user avatar.");
                                   }
                                   return;
                               }
                               UIImage *avatar = [UIImage imageWithData:data];

                               self.rearAvatar.image = avatar;

                               UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                               UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
                               effectView.frame = self.rearAvatar.frame;
                               [self.rearAvatar addSubview:effectView];

                               self.frontAvatar.image = avatar;
                               self.frontAvatar.layer.cornerRadius = 30.0;
                               self.frontAvatar.layer.borderColor = [[UIColor grayColor] CGColor];
                               self.frontAvatar.layer.borderWidth = 2.0;
                               self.frontAvatar.layer.masksToBounds = YES;

                               [self updateScrollViewContentSize];
                               [self dismissActivityIndicator];
                           }];

    [[CXNEventsService sharedInstance] trackEventWithName:@"Profile View"
                                          forPageWithName:@"User Profile"
                                                   andUrl:[NSString stringWithFormat:@"%@/profileinterests", kCxenseSiteBaseUrl]
                                          andRefferingUrl:kCxenseSiteBaseUrl
                                        byTrackerWithName:@"Profile"];

    [self updateScrollViewContentSize];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[CXNEventsService sharedInstance] trackActiveTimeOfEventWithName:@"Profile View"
                                                          trackerName:@"Profile"];
}

#pragma MARK: UI events handling methods

- (IBAction)handleLogout:(UIButton *)sender {
    [[UserService sharedInstance] logout];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma MARK: Utility methods

-(void)updateScrollViewContentSize {
    CGRect contentRect = CGRectZero;
    for (UIView *subview in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, subview.frame);
    }
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                             contentRect.size.height <= self.view.frame.size.height ? self.view.frame.size.height + 20 : contentRect.size.height);
}

@end
