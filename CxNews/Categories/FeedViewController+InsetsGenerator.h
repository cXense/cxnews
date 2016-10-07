//
//  FeedViewController+InsetsGenerator.h
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "FeedViewController.h"

/**
 Extends FeedViewController and adds ability to calculate edge insets
 for UICollecitonView's sections dynamically depending on device's screen size/
 */
@interface FeedViewController (InsetsGenerator)

/**
 Calculate edge insets taking into account current device's screen size.

 @return current device specific edge insets
 */
+(UIEdgeInsets)calculateEdgeInsets;

@end
