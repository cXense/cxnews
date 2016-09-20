//
//  UIViewController+Indicatator.h
//  CxNews
//
//  Created by Anver Bogatov on 13.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit.UIActivityIndicatorView;
@import UIKit.UIViewController;

@interface UIViewController (Indicator)
/**
 * Show activity indicator at the center of the screen. 
 * Also network activity indicator will be shown.
 */
-(void)showActivityIndicator;

/**
 * Dismiss activity indicator that is shown at the moment.
 * Also dimsisses network activity indicator.
 */
-(void)dismissActivityIndicator;

@end
