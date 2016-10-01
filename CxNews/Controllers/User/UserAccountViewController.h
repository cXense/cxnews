//
//  UserAccountViewController.h
//  CxNews
//
//  Created by Anver Bogatov on 05.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import UIKit;

@interface UserAccountViewController : UIViewController

@property(weak, nonatomic) IBOutlet UILabel *labelName;
@property(weak, nonatomic) IBOutlet UILabel *labelEmail;
@property(weak, nonatomic) IBOutlet UILabel *labelGender;
@property(weak, nonatomic) IBOutlet UILabel *labelBirthYear;
@property(weak, nonatomic) IBOutlet UILabel *labelExternalId;
@property(weak, nonatomic) IBOutlet UILabel *labelLocation;

@property(weak, nonatomic) IBOutlet UIImageView *rearAvatar;
@property(weak, nonatomic) IBOutlet UIImageView *frontAvatar;

- (IBAction)handleLogout:(UIButton *)sender;

- (IBAction)handleInterests:(UIButton *)sender;
@end
