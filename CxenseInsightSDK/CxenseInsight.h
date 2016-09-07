/*!
 @header    CxenseInsight.h
 @abstract  Cxense Insight iOS SDK Header
 @version   2.0
 @copyright Copyright (c) 2015 Cxense ASA. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "CxenseInsightTracker.h"
#import "CxenseInsightEventBuilder.h"

/** 
* These constants indicate the error when Cxense Insight fail to track an event.
*/
typedef NS_ENUM(NSInteger, CxenseInsightError) {
    CxenseInsightErrorUnknown = 0,
    CxenseInsightErrorUndefinedDispatchMode = 1,
    CxenseInsightErrorInvalidEventName = 2,
    CxenseInsightErrorEventMissingRequiredParameter = 3
};

/**
* CxenseInsightDispatchMode
* The Dispatch mode specify how and when the SDK will dispatch events to the Cxense Insight system.
*/
typedef NS_ENUM(NSInteger, CxenseInsightDispatchMode) {
    CxenseInsightDispatchModeNone,
    CxenseInsightDispatchModeOffline,
    CxenseInsightDispatchModeOnline
};

/**
* These constants define the minimum network connection required to dispatch events.
*/
typedef NS_ENUM(NSInteger, CxenseInsightNetworkRestriction) {
    CxenseInsightNetworkRestrictionNone = -1,
    CxenseInsightNetworkRestrictionGPRS = 0,
    CxenseInsightNetworkRestrictionMobile = 1,
    CxenseInsightNetworkRestrictionWifi = 2
};

@protocol CxenseInsightLocation <NSObject>
- (double)latitude;
- (double)longitude;
- (double)altitude;
- (double)horizontalAccuracy;
- (double)verticalAccuracy;
- (double)speed;
- (double)course;
- (NSDate *)timestamp;
@end

@interface CxenseInsight : NSObject

/**
* Creates or retrieves a CxenseInsightTracker with the specified SiteId and name. If a
* tracker for the specified name does not already exist, then it will be created and returned.
* If a tracker already exist it will be returned. If the existing tracker has a different
* Site Id set, that Site Id is not changed by this method. To do that you need to
* retrieve the tracker and set a new SiteId on it directly.
*
* @param siteId The site id to use for this tracker. If it is different than the Site Id
* already set on an existing tracker it will be ignored.
*
* @param name Optional name of the tracker. When a name is specified Cxense Insight will
* retain the tracker and allow for a convenient way to retrieve the same tracker again.
*
* @return A CxenseInsightTracker for the specified name. The tracker is used to send events
* to Cxense Insight. Subsequent calls to this method with the same name will return the same
* instance. The tracker is retained by the library.
*/
+ (CxenseInsightTracker *)trackerWithName:(NSString *)name siteId:(NSString *)siteId;

/**
* Set an appropriate Dispatch Mode to be used by the library. When in Online mode the library
* will try to dispatch events as they are tracked. In Offline mode you have the option to
* control dispatching manually using the -dispatch method. This might be desirable when trying
* to conserve battery life for your users and you can dispatch events along with other network
* traffic. See Apple's guidelines regarding battery life for more information related to this.
*
* @param mode The CxenseInsightDispatchMode that should be used.
* The default dispatch mode is CxenseInsightDispatchModeOnline.
*/
+ (void)setDispatchMode:(CxenseInsightDispatchMode)mode;

/**
* Retrieve the Dispatch Mode being used by the library.
*
* @return The dispatch mode being used by the library.
*/
+ (CxenseInsightDispatchMode)dispatchMode;

/**
* The network restriction defines the minimum available network connection that is
* required for reporting events.
*
* @discussion Use this property to set a restriction that fit the context in which
* your application will be used. If the currently available network connection is
* worse than the network restriction you've defined events will not be dispatched..
*
* The default value is CxenseInsightNetworkRestrictionNone
*/
+ (void)setNetworkRestriction:(CxenseInsightNetworkRestriction)restriction;


+ (CxenseInsightNetworkRestriction)networkRestriction;

/**
* Defines the interval the SDK transmits tracked events to Cxense Insight. The interval
* is measured in seconds. Dispatches will only occur when the application is first
* launched or resumed from a background state. Setting an interval to a value <= 0 will
* result in no automatic dispatch of events. In this case all dispatching of events have to
* be managed using the -dispatch method.
*
* If CxenseInsightDispatchModeOnline is used this interval will be ignored. The app will
* attempt to transfer events whenever they are tracked - if the current network restriction
* allows it, taking the current network reachability into account.
*
*  Default value: 300 (5 minutes)
*/
+ (void)setDispatchInterval:(NSInteger)interval;
+ (NSInteger)dispatchInterval;

/**
* The Cxense Insight SDK is using a  User-Agent for all network calls that is equal
* that of a normal WebView's default User-Agent. You have the option to override
* this User-Agent by setting this property to something else.
*
* When set to nil it will reset back to using the WebView User-Agent again.
*
* Default value: WebView's default User-Agent.
*/
+ (void)setUserAgent:(NSString *)userAgent;
+ (NSString *)userAgent;

/**
Manually dispatch events. This is useful when using Cxense Insight in CxenseInsightDispatchModeOffline.
*/
+ (void)dispatch;

/**
* Returns the default UserId that is being used in CxenseInsightTrackers, unless you override it by setting a specific id.
*
* This id uses the IDFA (Identifier for Advertisers) when the AdSupport framework is linked and will fallback to the Vendor
* Identifier It will respect your users privacy settings related to IDFA. If you want to opt out of the use of IDFA you can
* override the userId on each CxenseInsightTracker instance.
*
* When using Cxense Insight SDK in combination with other Cxense SDKs you can create own persistent ids and reuse them to
* e.g. associate a Cxense Insight pageview event with a DMP event.
*/
+ (NSString *)defaultUserId;

@end


