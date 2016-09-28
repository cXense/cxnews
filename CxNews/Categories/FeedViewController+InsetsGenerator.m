//
//  FeedViewController+InsetsGenerator.m
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "FeedViewController+InsetsGenerator.h"

@implementation FeedViewController (InsetsGenerator)

+(UIEdgeInsets)calculateEdgeInsets {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight <= 480) {
        NSLog(@"[Returning edge insets for iPhone 4 type");
        return [self edgeInsetsForIPhones4Type];
    } else if (screenHeight <= 568) {
        NSLog(@"[Returning edge insets for iPhone 5 type");
        return [self edgeInsetsForIPhones5Type];
    } else if (screenHeight <= 667) {
        NSLog(@"[Returning edge insets for iPhone 6 type");
        return [self edgeInsetsForIPhones6Type];
    } else {
        NSLog(@"[Returning edge insets for iPhone 6 Plus type");
        return [self edgeInsetsForIPhones6PlusType];
    }
}

/**
 Return edge insets fit for devices of Plus type,
 like iPhone 4(s).

 @return specific edge insets
 */
+(UIEdgeInsets)edgeInsetsForIPhones4Type {
    return UIEdgeInsetsMake(10, 3, 10, 3);
}

/**
 Return edge insets fit for devices of Plus type,
 like iPhone 5(s) or iPhone SE.

 @return specific edge insets
 */
+(UIEdgeInsets)edgeInsetsForIPhones5Type {
    // same as for iPhone 4 type
    return [self edgeInsetsForIPhones4Type];
}

/**
 Return edge insets fit for devices of Plus type,
 like iPhone 6(s) or iPhone 7.

 @return specific edge insets
 */
+(UIEdgeInsets)edgeInsetsForIPhones6Type {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


/**
 Return edge insets fit for devices of Plus type,
 like iPhone 6(s) Plus or iPhone 7 Plus.

 @return specific edge insets
 */
+(UIEdgeInsets)edgeInsetsForIPhones6PlusType {
    return UIEdgeInsetsMake(20, 35, 20, 35);
}

@end
