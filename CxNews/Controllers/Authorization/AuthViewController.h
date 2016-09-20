//
//  AuthViewController.h
//  CxNews
//
//  Created by Anver Bogatov on 01.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController <UITextFieldDelegate>

/**
 * Text field that stores specified email.
 */
@property(weak, nonatomic) IBOutlet UITextField *emailTextField;

/**
 * Text field that stores specified password.
 */
@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;

/**
 * Button for submitting user login and password to server.
 */
@property(weak, nonatomic) IBOutlet UIButton *submitButton;

/**
 * Button for accessing 3rd party password management applications.
 */
@property (weak, nonatomic) IBOutlet UIButton *passExtensionButton;

/**
 * Handle 'Enter' button pressed event by gathering email and password
 * from login form and submitting them to Cxense API.
 */
- (IBAction)submitButtonPressed:(UIButton *)sender;

/**
 * Handle 'or Skip' button pressed event by allowing user to work in 'guest' mode.
 */
- (IBAction)skipButtonPressed:(UIButton *)sender;
@end
