//
//  VideoFeedTableViewController+CellHeightGenerator.h
//  CxNews
//
//  Created by Anver Bogatov on 01.10.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "VideoFeedTableViewController.h"

/**
 Cell Height Generator is responsible for dynamic calculation of
 cell's height for video feed table view controller.
 */
@interface VideoFeedTableViewController (CellHeightGenerator)


/**
 Returns dynamically calculated height for cell in video feed view.

 @return cell height
 */
- (CGFloat)heightForVideoCell;

@end
