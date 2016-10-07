//
//  UIViewController+Indicatator.m
//  CxNews
//
//  Created by Anver Bogatov on 13.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import UIKit.UIActivityIndicatorView;
#import "UIViewController+Indicator.h"
#import "Constants.h"

@implementation UIViewController (Indicator)

-(void)showActivityIndicator {
    UIActivityIndicatorView *indicator = [self.view viewWithTag:kCxenseActivityIndicatorTag];
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = self.view.center;
        indicator.tag = kCxenseActivityIndicatorTag;
        [self.view addSubview:indicator];
        [indicator bringSubviewToFront:self.view];
    }
    [indicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)dismissActivityIndicator {
    UIActivityIndicatorView *indicator = [self.view viewWithTag:kCxenseActivityIndicatorTag];
    if (indicator) {
        [indicator stopAnimating];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
