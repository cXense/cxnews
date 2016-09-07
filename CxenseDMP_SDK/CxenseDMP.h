//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CxenseDMPCustomParameter.h"
#import "CxenseDMPEvent.h"
#import "CxenseDMPExternalData.h"
#import "CxenseDMPExternalProfile.h"
#import "CxenseDMPGroup.h"
#import "CxenseDMPProfile.h"
#import "CxenseDMPUser.h"
#import "CxenseDMPUserIdentifier.h"

@class CxenseDMPUser;
@class CxenseDMPUserIdentifier;

typedef NS_ENUM(NSInteger, CxenseDMPError) {
    CxenseDMPErrorIncompleteConfiguration = 10,
    CxenseDMPErrorBadRequest              = 400,
    CxenseDMPErrorUnauthorized            = 401,
    CxenseDMPErrorForbidden               = 403,
    CxenseDMPErrorUnknownRequestError     = 499
};

@interface CxenseDMP : NSObject

/**
* Set username & apiKey for use in all requests done by the library. Both username & apiKey are required.
*
* @param username   The email address you use when you sign in to https://insight.cxense.com
* @param apiKey     Your API key can be obtained by clicking on your username in the top right corner
*                   of the screen after having signed in to https://insight.cxense.com.
*/
+ (void)setUsername:(NSString *)username apiKey:(NSString *)apiKey;
+ (NSString *)username;
+ (NSString *)apiKey;

/**
* Retrieves a suitably authorized slice of a given user's interest profile.
* The returned profile data will have been gathered from within the network of sites
* that the client has access to. This includes data from, e.g., custom taxonomies and
* custom parameters.
*
* @param userId         Identifies the user whose interest profile should be returned.
*
* @param identifierType The type of user identifier. The value "cx" indicates that the identifier
*                       is the site-specific Cxense identifier value, as read using the cX.getUserId()
*                       function call from cx.js. Customer-specific identifiers via a customer-assigned
*                       prefix are also possible.
*
* @param completion     Completion block which is called with a CxenseDMPUser and NSError object if
*                       an error occurred.
*/
+ (void)getUserProfileWithUserId:(NSString *)userId
                  identifierType:(NSString *)identifierType
                      completion:(void (^)(CxenseDMPUser *user, NSError *error))completion;

/**
* Retrieves a suitably authorized slice of a given user's interest profile.
* The returned profile data will have been gathered from within the network of sites that the client
* has access to. This includes data from, e.g., custom taxonomies and
* custom parameters.
*
* @param userId         Identifies the user whose interest profile should be returned.
*
* @param identifierType The type of user identifier. The value "cx" indicates that the identifier
*                       is the site-specific Cxense identifier value, as read using the cX.getUserId()
*                       function call from cx.js. Customer-specific identifiers via a customer-assigned
*                       prefix are also possible.
*
* @param groups         A list of strings that specify profile item groups to keep in the returned
*                       profile. If not specified, all groups available for the user will be returned.
*                       Group specifications may enable server-side optimizations on Cxense's side,
*                       which can lead to a quicker response.
*
* @param recent         Returns quickly if this user has not been seen recently. Cxense stores user
*                       profile information in many storage layers, where the most recently seen profiles
*                       are the quickest profiles to retrieve. In an interactive session where events are
*                       generated (and as a consequence the user profile is updated and considered a fresh
*                       profile), it may be more appropriate to return quickly than wait for a complete
*                       response on the first page view.
*
* @param identityTypes  A list of external customer identifier types. If an external customer identifier
*                       exists for the user, it will be included in the response (the identifier would
*                       first have been added through the addExternalId() Javascript API, or through
*                       the SDK using setUserExternalLinkWithUserId:identifierType:cxenseId:completion:).
*
* @param completion     Completion block which is called with a CxenseDMPUser and a NSError object if an
*                       error occurred.
*/
+ (void)getUserProfileWithUserId:(NSString *)userId
                  identifierType:(NSString *)identifierType
                          groups:(NSArray *)groups
                          recent:(BOOL)recent
                   identityTypes:(NSArray *)identityTypes
                      completion:(void (^)(CxenseDMPUser *user, NSError *error))completion;


/**
* Retrieves a list of all segments where the user is a member.
*
* @param identifiers    An array of CxenseDMPUserIdentifier object representing the externally defined
*                       identifier for the user and the built-in user identifier type "cx", or the customer
*                       identifier type as registered with Cxense.
*
* @param siteGroupIds   An array of site groups to retrieve segments for.
*
* @param completion     Completion block which is called with an array of segments (strings) and a NSError
*                       object if an error occurred.
*/
+ (void)getSegmentsForUserIdentifiers:(NSArray *)identifiers
                         siteGroupIds:(NSArray *)siteGroupIds
                           completion:(void (^)(NSArray *segments, NSError *error))completion;


/**
* Set information which will be associated with a given user. This information can later be retrieved, used
* as a factor in statistical analyses, ad matching or other purposes.
*
* @param userId         The externally defined identifier for the user.
* @param identifierType The customer identifier type as registered with Cxense (Customer Prefix).
* @param profiles       Array of CxenseDMPExternalProfile objects. There is a limit of 40 profile objects.
* @param completion     Completion block which is called with a boolean value indicating if the update was
*                       a success, and an NSError object if an error occurred.
*/
+ (void)updateUserExternalDataWithUserId:(NSString *)userId
                          identifierType:(NSString *)identifierType
                                profiles:(NSArray *)profiles
                              completion:(void (^)(BOOL success, NSError *error))completion;

/**
* Retrieves the uploaded data for all users for the specified type is returned.
*
* @param identifierType The customer identifier type as registered with Cxense (Customer Prefix)
*
* @param completion     Completion block which is called with an array of CxenseDMPExternalData objects and
*                       an NSError object if an error occurred.
*/
+ (void)getUserExternalDataWithIdentifierType:(NSString *)identifierType
                                   completion:(void (^)(NSArray *data, NSError *error))completion;

/**
* Retrieves the annotated data which has been uploaded and associated with a specific user. If no user
* id is provided, the uploaded data for all users for this type is returned.
*
* @param userId         The externally defined identifier for the user.
*
* @param identifierType The customer identifier type as registered with Cxense (Customer Prefix)
*
* @param completion     Completion block which is called with an array of CxenseDMPExternalData objects and
*                       an NSError object if an error occurred.
*/
+ (void)getUserExternalDataWithUserId:(NSString *)userId
                       identifierType:(NSString *)identifierType
                           completion:(void (^)(NSArray *data, NSError *error))completion;

/**
* Deletes all the uploaded information associated with a specified user.
*
* @param userId         The externally defined identifier for the user.
* @param identifierType The customer identifier type as registered with Cxense (Customer Prefix)
* @param completion     Completion block which is called with a boolean value indicating if the deletion was
*                       a success, and an NSError object if an error occurred.
*/
+ (void)deleteUserExternalDataWithUserId:(NSString *)userId identifierType:(NSString *)identifierType completion:(void (^)(BOOL success, NSError *error))completion;

/**
* Retrieves a registered external identity mapping for a Cxense identifier. The mapping has either been
* added using the Javascript addExternalId() api call described in the Event data documentation, or through
* the SDK and -setUserExternalLinkWithUserId:identifierType:cxenseId:completion:)
*
* @param cxenseId       The Cxense identifier of the user.
* @param identifierType The identity mapping type (customer identifier type) that contains the mapping.
* @param completion     Completion block which is called with a CxenseDMPUserIdentifier and a NSError object
*                       if an error occurred.
* @return
*/
+ (void)getUserExternalLinkWithCxenseId:(NSString *)cxenseId identifierType:(NSString *)identifierType completion:(void (^)(CxenseDMPUserIdentifier *userIdentifier, NSError *error))completion;

/**
* Register a new identity-mapping. If the identifier of the specified type already exists, then the cxenseId is
* mapped to that one, else the new mapping is set to point to the cxenseId. This makes it possible to link
* customer identifiers (such as a subscriber number) to the device the user is using.
*
* @param userId         The identifier value to register.
* @param identifierType The customer identifier type as registered with Cxense (Customer Prefix)
* @param cxenseId       The Cxense identifier to map this user to.
* @param completion     Completion block which is called with a CxenseDMPUserIdentifier and a NSError object
*                       if an error occurred.
*/
+ (void)setUserExternalLinkWithUserId:(NSString *)userId identifierType:(NSString *)identifierType cxenseId:(NSString *)cxenseId completion:(void (^)(CxenseDMPUserIdentifier *userIdentifier, NSError *error))completion;

/**
* Feed DMP events to Cxense.
*
* @param event      The CxenseDMPEvent to feed.
* @param completion Completion block which is called with a boolean value indicating if the request was
*                   a success, and an NSError object if an error occurred.
*/
+ (void)pushEvent:(CxenseDMPEvent *)event completion:(void (^)(BOOL success, NSError *error))completion;

/**
* Feed multiple DMP events to Cxense.
*
* @param events     Array of CxenseDMPEvent objects to feed.
* @param completion Completion block which is called with a boolean value indicating if the request was
*                   a success, and an NSError object if an error occurred.
*/
+ (void)pushEvents:(NSArray *)events completion:(void (^)(BOOL success, NSError *error))completion;

/**
* Returns the default UserId for Cxense SDKs, this id is the same across all of our SDKs.
*
* This id uses the IDFA (Identifier for Advertisers) when the AdSupport framework is linked and will
* fallback to the Vendor Identifier if not. It will respect your users privacy settings related to IDFA.
* If you want to opt out of the use of IDFA you can generate a new unique id to use in all SDK calls instead.
*
* When generating new ids you need to make sure they follow these rules; at least 16 characters long and
* only the allowed characters A-Z, a-z, 0-9, "_", "-", "+" and ".". A convenient way to achieve a new unique
* userId that fit this pattern is to use the NSUUID class.
*
* NSString *userId = [[NSUUID UUID] UUIDString];
*/
+ (NSString *)defaultUserId;

@end
