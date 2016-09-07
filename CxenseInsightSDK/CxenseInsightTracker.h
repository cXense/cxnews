//
// Copyright (c) 2015 Cxense ASA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CxenseInsightLocation;
@interface CxenseInsightTracker : NSObject

/**
* Set default parameter that will be included in all tracked events. If the event contains a parameter that
* is also set on the Tracker-level then the event parameter will be used instead.
*
* Setting default parameters can be useful when you need to include custom parameters on all events.
*/
- (void)setParameter:(NSString *)parameter forKey:(NSString *)key;

/**
* Retrieves the parameter value for the specified key.
*
* @return NSString the parameter for the specified key.
*/
- (NSString *)parameterForKey:(NSString *)key;

/**
* The default parameters in the Tracker.
*
* @return NSDictionary with all parameters in the tracker. This dictionary is a deep-copy of the internal
*         parameter dictionary.
*/
- (NSDictionary *)parameters;

/**
* The Site Id from Cxense Insight (the site which will have tracked events associated with it)
* @discussion Your siteId can be found when you login to your account at the Cxense Insight website
* @see http://insight.cxense.com Cxense Insight Website
* @warning There is no default value for siteID. It is a requirement that it is set to a valid Site Id
* for tracking to function properly.
*/
- (void)setSiteId:(NSString *)siteId;
- (NSString *)siteId;

/**
* Set a specific userId to be used instead of the default id. The id must be at least 16 characters long.
* Allowed characters: A-Z, a-z, 0-9, "_", "-", "+" and ".". A convenient way to achieve a new unique userId
* that fit this pattern is to use the NSUUID class.
*
* NSString *userId = [[NSUUID UUID] UUIDString];
*
* @param userId The id to use instead of the defaultUserId.
*/
- (void)setUserId:(NSString *)userId;

/**
* Returns the userId set for the tracker.
*
* @return NSString representing the userId that will be used for new events in the tracker.
*/
- (NSString *)userId;

/**
* Track a Cxense Insight event.
*
* @param event      NSDictionary representing an Insight event. The dictionary is best created using the
*                   CxenseInsightEventBuilder.
* @param name       Name of the tracked event. This is optional and only needed if you want to be able to
*                   track the active time for the event. This name is then used when reporting active time
*                   using the -reportActiveTimeForEvent: or -reportActiveTime:forEvent: methods.
*                   If the name was used previously by an event that has not yet had its time reported it
*                   will be replaced by the new event. You should either create named with autoincrement
*                   features or any other randomness if this is a problem for you.
* @param completion Completion block which returns the tracked event or an error if an error occurred. You
*                   can use the returned event object to retrieve the 'rnd' value for use with Cxense DMP
*                   events.
*/
- (void)trackEvent:(NSDictionary *)event name:(NSString *)name completion:(void (^)(NSDictionary *event, NSError *error))completion;

/**
* Track the active time for an event. This requires that the event had a name set when it was tracked.
* This method will measure the time between the time of the tracking of the event and the time this
* method was called, this time interval will represent the active time of the event. To manually report
* a specific active time, use trackActiveTime:forEvent: instead.
*
* @param name The name that was used when tracking the event.
*/
- (void)trackActiveTimeForEvent:(NSString *)name;

/**
* Track the active time for an event. This requires that the event had a name set when it was tracked.
*
* @param activeTime The active time for the event. This could represent the time that a ViewController was
*                   active.
* @param name       The name that was used when tracking the event.
*/
- (void)trackActiveTime:(NSTimeInterval)activeTime forEvent:(NSString *)name;

/**
* @function setExternalUserId:withType:
*
* @discussion Set external id and type that will be added to all future events.
*
* @param userId NSDictionary with externalUserId and Type pairs. Type should be the key, and userId the value in
*               the dictionary. If you pass nil or an empty dictionary then all external ids in the tracker will
*               be removed. There is a max of 5 external ids, if you provide more than 5, the first 5 will be used.
*/
- (void)setExternalUserIds:(NSDictionary *)userIds;

/**
* Set the Current Location enable associating events with a geolocation.
* @discussion The Cxense Insight SDK doesn't track location automatically, it is up to you to update this
* value to ensure that the correct location is associated with events (if this accuracy is important to you).
*
* @param latitude            Latitude value (double, equal to CLLocation's latitude value)
* @param longitude           Longitude value (double, equal to CLLocation's longitude value)
* @param altitude            Altitude value (double, equal to CLLocation's altitude value)
* @param horizontalAccuracy  Horizontal accuracy (double, equal to CLLocation's horizontalAccuracy value)
* @param verticalAccuracy    Vertical accuracy (double, equal to CLLocation's verticalAccuracy value)
* @param speed               Speed value (double, equal to CLLocation's speed value)
* @param heading             Heading value (double, equal to CLLocation's course value)
* @param timestamp           Timestamp (NSDate, equal to CLLocation's timestamp value)
*
* This method accepts parameters from a CLLocation object (or any other location object using the
* same measures for location).
*/
- (void)setCurrentLocationWithLatitude:(double)latitude
                             longitude:(double)longitude
                              altitude:(double)altitude
                    horizontalAccuracy:(double)horizontalAccuracy
                      verticalAccuracy:(double)verticalAccuracy
                                 speed:(double)speed
                                course:(double)course
                             timestamp:(NSDate *)timestamp;

/**
* Clears the current location information (if it has been set).
* @discussion Clears the current location information and events tracked in the future wont have any location data associated with them.
*/
- (void)clearCurrentLocation;

/**
* @discussion This is the most recent location that was set using
* -setCurrentLocationWithLatitude:longitude:horizontalAccuracy:verticalAccuracy:speed:course:timestamp:
* @return id<CxenseInsightLocation> The current location that future tracked events will be associated with.
*/
- (id <CxenseInsightLocation>)currentLocation;

@end