//
//  CxenseContentWidget.h
//  CxenseContent
//
//  Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CxenseContentWidgetErrorCode) {
    CxenseContentWidgetUnknownError
};

/**
 *  Completion block used when fetching new recommendations.
 *
 *  @param success  YES if the request was successful, NO if some error occured.
 *  @param items    An array of CxenseContentRecommendation objects.
 *  @param error    NSError to debug any error that occured.
 */
typedef void (^CxenseContentWidgetCompletion)(BOOL success, NSArray *items, NSError *error);

@class CxenseContentUser, CxenseContentContext, CxenseContentRecommendation;
@interface CxenseContentWidget : NSObject

/**
 *  The widget id for the widget in Cxense Content.
 */
@property (nonatomic, strong) NSString *widgetId;

/**
 *  Optional context for the widget
 */
@property (nonatomic, strong) CxenseContentContext *context;

/**
 *  Optional user for the widget
 */
@property (nonatomic, strong) CxenseContentUser *user;

/**
 *  Array of CxenseContentRecommendations objects for the widget.
 */
@property (nonatomic, strong, readonly) NSArray *items;


/**
 *  Registers a click on the recommendation
 */
+ (void)trackClick:(CxenseContentRecommendation *)recommendation;

/**
 *  Fetches recommendation items using the properties set on the widget. The recommendations are returned in the completion block as well as stored in the items property.
 */
- (void)fetchItemsWithCompletion:(CxenseContentWidgetCompletion)completion;

@end