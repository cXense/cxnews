//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CxenseDMPEvent.h"

@interface CxenseDMPUserIdentifier : NSObject <CxenseDMPDictionaryRepresentation>

/**
* Site specific identifier (type cx) or external user identifier type.
*/
@property(nonatomic, copy) NSString *type;

/**
* Value of the user identifier.
*/
@property(nonatomic, copy) NSString *identifier;

/**
* Creates and return a User Identifier object.
*
* @param type       Site specific identifier (type cx) or external user identifier type.
*
* @param identifier Value of the user identifier.
*
* @return CxenseDMPEventUserIdentifier object with the specified type and identifier set.
*/
+ (CxenseDMPUserIdentifier *)identifierWithType:(NSString *)type
                                     identifier:(NSString *)identifier;

@end