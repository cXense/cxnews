//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CxenseDMPDictionaryRepresentation <NSObject>
/**
 * Returns a dictionary (JSON) representation of the object implementing the protocol.
 */
- (NSDictionary *)dictionaryRepresentation;
@end

@interface CxenseDMPEvent : NSObject <CxenseDMPDictionaryRepresentation>

/**
* Array of CxenseDMPUserIdentifier objects.
*/
@property (nonatomic, strong) NSArray *userIds;

/**
* A value uniquely identifying the page request. That this value must be identical to rnd of the analytics event.
*/
@property (nonatomic, strong) NSString *prnd;

/**
* A value uniquely identifying the action. Multiple actions on the same page view, must have distinct rnd values.
*/
@property (nonatomic, strong) NSString *rnd;

/**
* The analytics site identifier to be associated with the events.
*/
@property (nonatomic, strong) NSString *siteId;

/**
* Differentiates various DMP applications used by the customer. Must be prefixed by the customer prefix.
*/
@property (nonatomic, strong) NSString *origin;

/**
* Differentiates various event types, e.g., "click", "impression", "conversion", etc.
*/
@property (nonatomic, strong) NSString *type;

/**
* An optional list of matching segments to be reported (array of ids (strings)).
*
* Optional.
*/
@property (nonatomic, strong) NSArray *segmentIds;

/**
* An optional list of customer-defined parameters. Array of CxenseDMPCustomParameter objects.
*
* Optional.
*/
@property (nonatomic, strong) NSArray *customParameters;

/**
*   Creates and return a CxenseDMPEvent object with the specified parameters set. All parameters
*   of this method are required for a Cxense DMP Event.
*
*   @param userIds  Array of known user identities (CxenseDMPEventUserIdentity objects) to identify
*                   the user. Note that different users must be fed as different events.
*   @param prnd     A value uniquely identifying the corresponding page view event, i.e. it must be
*                   identical to the rnd value of the pageview event.
*   @param siteId   The analytics site identifier to be associated with the events.
*   @param origin   Differentiates various DMP applications. Must be prefixed by the customer prefix.
*   @param type     Differentiates various event types, e.g., "click", "impression", "conversion", etc.
*
*   @return CxenseDMPEvent object with the specified (all required) parameters. To create an event
*           with the optional parameters set, use the other convenience method.
*/
+ (CxenseDMPEvent *)eventWithUserIds:(NSArray *)userIds prnd:(NSString *)prnd siteId:(NSString *)siteId origin:(NSString *)origin type:(NSString *)type;

/**
* Creates and return a CxenseDMPEvent object with the specified parameters set. Required parameters
* are userIds, prnd, siteId, origin and type.
*
* @param userIds          Array of known user identities (CxenseDMPUserIdentity objects) to identify the user.
*                         Note that different users must be fed as different events.
*
* @param prnd             A value uniquely identifying the corresponding page view event, i.e. it must be
*                         identical to the rnd value of the pageview event.
*
* @param rnd              A value uniquely identifying the action. Multiple actions on the same page view, must
*                         have distinct rnd values.
*
* @param siteId           The analytics site identifier to be associated with the events.
* @param origin           Differentiates various DMP applications. Must be prefixed by the customer prefix.
* @param type             Differentiates various event types, e.g., "click", "impression", "conversion", etc.
* @param segmentIds       An optional list of matching segments to be reported.
* @param customParameters An optional list of customer-defined parameters.
*
* @return CxenseDMPEvent object with the specified (all required) parameters. To create an event with the optional
*         parameters set, use the other convenience method.
*/
+ (CxenseDMPEvent *)eventWithUserIds:(NSArray *)userIds prnd:(NSString *)prnd rnd:(NSString *)rnd siteId:(NSString *)siteId origin:(NSString *)origin type:(NSString *)type segmentIds:(NSArray *)segmentIds customParameters:(NSArray *)customParameters;

@end