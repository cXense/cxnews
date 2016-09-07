//
//  AuthViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 01.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "AuthViewController.h"
#import "UserService.h"
#import "SWRevealViewController.h"
#import "CxenseInsight.h"
#import "GenericPasswordExtension.h"
#import "CXNEventsService.h"
#import "Constants.h"

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.emailTextField.returnKeyType = UIReturnKeySend;
    self.passwordTextField.returnKeyType = UIReturnKeySend;

    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;

    self.emailTextField.layer.cornerRadius = kCxenseAuthControlsCornerRadius;
    self.passwordTextField.layer.cornerRadius = kCxenseAuthControlsCornerRadius;
    self.submitButton.layer.cornerRadius = kCxenseAuthControlsCornerRadius;

    [self.passExtensionButton setHidden:![[GenericPasswordExtension sharedExtension] isAppExtensionAvailable]];

    /*
     Following lines of code nothing more than workaround for cookie storage initialization. Since we don't have dedicated API on the portal, we need to get specific cookie with user persistent id that is initialized by javascript code right on the main page of the portal. So, these lines of code are needed only for NSHTTPCookieStorage initialization.
     */
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cxnews.azurewebsites.net"]]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CXNEventsService sharedInstance] trackEventWithName:@"Auth View"
                                          forPageWithName:@"Login page"
                                                   andUrl:@"http://cxnews.azurewebsites.net/Account/Login"
                                          andRefferingUrl:nil
                                        byTrackerWithName:@"Auth"];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[CXNEventsService sharedInstance] trackActiveTimeOfEventWithName:@"Auth View"
                                                          trackerName:@"Auth"];
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    if (self.emailTextField.text.length == 0) {
        [self showErrorAlertViewWithMessage:@"Please provide user email."];
        return;
    }

    if (self.passwordTextField.text.length == 0) {
        [self showErrorAlertViewWithMessage:@"Please provide user password."];
        return;
    }

    if (![[UserService sharedInstance] isUserAuthorized]) {
        [[UserService sharedInstance] logout];
        AuthorizationResult authResult = [[UserService sharedInstance] authWithLogin:self.emailTextField.text
                                                                         andPassword:self.passwordTextField.text];
        if (authResult == OK) {
            NSLog(@"Auth attempt has succeed");
        } else if (authResult == Failed) {
            NSLog(@"Auth attempt has failed");
            [self showErrorAlertViewWithMessage:@"Authorization failed. Please check email & password you have specified."];
            return;
        }
    } else {
        NSLog(@"User already logged in");
    }

    [self showFeedView];
}

- (IBAction)skipButtonPressed:(UIButton *)sender {
    NSLog(@"Skip button was pressed");
    [self showFeedView];
}

- (void)showFeedView {
    __kindof SWRevealViewController *vc = [[UIStoryboard storyboardWithName:@"Main"
                                                                     bundle:nil] instantiateViewControllerWithIdentifier:@"revealViewController"];
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

- (void)showErrorAlertViewWithMessage:(NSString *)message {
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

# pragma mark - Password share extension

- (IBAction)handlePasswordExtensionTap:(UIButton *)sender {
    [[GenericPasswordExtension sharedExtension] findLoginForURLString:@"http://cxnews.azurewebsites.net"
                                                    forViewController:self
                                                               sender:sender
                                                           completion:^(NSDictionary *loginDict, NSError *error) {
                                                               NSLog(@"Here is: %@", [loginDict description]);
                                                               self.emailTextField.text = loginDict[AppExtensionUsernameKey];
                                                               self.passwordTextField.text = loginDict[AppExtensionPasswordKey];
                                                           }];
}


# pragma mark - UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self submitButtonPressed:nil];
    return NO;
}
@end
