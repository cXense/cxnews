//
//  Constants.h
//  CxNews
//
//  Created by Anver Bogatov on 04.06.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation.NSString;
@import Foundation.NSDate;
@import CoreGraphics.CGBase;

extern NSString *kCxenseCrmBaseUrl;
extern NSString *kCxenseSiteBaseUrl;

extern NSString *kCxenseWidgetId;

extern NSTimeInterval kCxenseCacheClearTimeoutInSeconds;

extern CGFloat kCxenseAuthControlsCornerRadius;

/** Article View font configuration */
extern CGFloat kCxenseTextContentFontSizeIPhone;
extern CGFloat kCxenseTextContentFontSizeIPad;
extern CGFloat kCxenseHeadlineFontSizeIPhone;
extern CGFloat kCxenseHeadlineFontSizeIPad;

/** Lorem Ipsum template. Can be used in places where original text is not enough. */
extern NSString *kCxenseFakeTextContent;

/** Cxense Insight application's site id */
extern NSString *kCxenseInsightSiteId;

/** Keys for NSUserDefault. */
extern NSString *kCxenseUserProfileId;
extern NSString *kCxenseExternalUserId;

/** Tag for activity indicator */
extern NSInteger kCxenseActivityIndicatorTag;

/** Tag for Rear menu item. */
extern NSInteger kCxenseRearMenuItemTag;

/** Feed View Cell's tags */
extern NSInteger kCxenseFeedViewCollectionViewCellImageTag;
extern NSInteger kCxenseFeedViewCollectionViewCellBodyTag;
extern NSInteger kCxenseFeedViewCollectionViewCellTitleTag;
extern NSInteger kCxenseFeedViewCollectionViewCellTimestampTag;

/** Feed View Supplementary Cell's tags */
extern NSInteger kCxenseFeedViewCollectionViewSupplementaryCellImageTag;
extern NSInteger kCxenseFeedViewCollectionViewSupplementaryCellButtonTag;
extern NSInteger kCxenseFeedViewCollectionViewSupplementaryCellTitleTag;

/** Video feed view cell's tags */
extern NSInteger kCxenseVideoFeedTableViewCellImageTag;
extern NSInteger kCxenseVideoFeedTableViewCellTimestampTag;
extern NSInteger kCxenseVideoFeedTableViewCellTitleTag;
