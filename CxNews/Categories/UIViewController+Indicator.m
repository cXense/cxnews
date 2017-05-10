//
//  UIViewController+Indicatator.m
//  CxNews
//
//  Created by Anver Bogatov on 13.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "UIViewController+Indicator.h"
#import "Constants.h"
#import "MBProgressHUD.h"

@implementation UIViewController (Indicator)

-(void)showActivityIndicator {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)dismissActivityIndicator {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
