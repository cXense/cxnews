//
//  VideoFeedTableViewController+CellHeightGenerator.m
//  CxNews
//
//  Created by Anver Bogatov on 01.10.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "VideoFeedTableViewController+CellHeightGenerator.h"

@implementation VideoFeedTableViewController (CellHeightGenerator)

- (CGFloat)heightForVideoCell {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight <= 568) {
        return 160.0;
    } else if (screenHeight <= 667) {
        return 180.0;
    } else if (screenHeight <= 736) {
        return 200.0;
    } else {
        return 300.0;
    }
}

@end
