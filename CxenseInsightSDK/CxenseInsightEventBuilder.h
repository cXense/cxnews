//
// Copyright (c) 2015 Cxense ASA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CxenseInsightLocation;
@interface CxenseInsightEventBuilder : NSObject

/**
* Set Parameters
*
* Parameters set on the event will override any parameters set on the CxenseInsightTracker.
*
* @param parameter The parameter to set for the specified key
* @param key       The key for the parameter
*/
- (void)setParameter:(NSString *)parameter forKey:(NSString *)key;

/**
* Set Custom Parameters
*
* These keys will be automatically prefixed with cp_ in line with the Cxense Insight HTTP Api
* (if the key is missing cp_ prefix).
*
* @param parameter The parameter to set for the specified key
* @param key       The key for the parameter
*/
- (void)setCustomParameter:(NSString *)parameter forKey:(NSString *)key;

/**
* Set User Profile Parameters
*
* These keys will be automatically prefixed with cp_u_ in line with the Cxense Insight HTTP Api
* (if the key is missing cp_u_ prefix).
*
* @param parameter The parameter to set for the specified key
* @param key       The key for the parameter
*/
- (void)setUserProfileParameter:(NSString *)parameter forKey:(NSString *)key;

/**
* Retrieve the value for a specific key.
*
* @param key The key for the parameter you wish to retrieve.
*
* @return NSString Parameter for the specified key.
*/
- (NSString *)parameterForKey:(NSString *)key;

/**
* Builds and returns a NSMutableDictionary representing an Insight Event.
* The keys are all documented for the Cxense Insight HTTP Api.
*
* @return NSMutableDictionary A dictionary representing the event to track.
*/
- (NSMutableDictionary *)build;

/**
* Create a CxenseInsightEventBuilder for a PageView event with the specified url.
*
* @param url The url of the page view.
*
* @return CxenseInsightEventBuilder builder with parameters set for a pageview with the specified url.
*/
+ (CxenseInsightEventBuilder *)pageViewEventWithURL:(NSString *)url;

/**
* Create a CxenseInsightEventBuilder for a PageView event with the specified url.
*
* @param url          The url of the page view.
* @param referringUrl The referring url of the pageview (where did the user come from). Optional parameter.
*
* @return CxenseInsightEventBuilder builder with parameters set for a pageview with the specified url and referring url.
*/
+ (CxenseInsightEventBuilder *)pageViewEventWithURL:(NSString *)url referringURL:(NSString *)referringUrl;

/**
* Create a CxenseInsightEventBuilder for a PageView event with the specified url.
*
* @param url          The url of the page view.
* @param referringUrl The referring url of the pageview (where did the user come from). Optional parameter.
* @param siteId       The siteId for the Page View event. If specified this will override the tracker's siteId
*                     setting for this particular event. Optional parameter.
*
* @return CxenseInsightEventBuilder builder with parameters set for a pageview with the specified url, referring url and siteId.
*/
+ (CxenseInsightEventBuilder *)pageViewEventWithURL:(NSString *)url referringURL:(NSString *)referringUrl siteId:(NSString *)siteId;

@end
