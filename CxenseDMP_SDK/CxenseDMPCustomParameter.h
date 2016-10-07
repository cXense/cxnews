//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CxenseDMPEvent.h"

@interface CxenseDMPCustomParameter : NSObject <CxenseDMPDictionaryRepresentation>

/**
* The parameter name, e.g., "campaign", "adspace" or "creative".
*/
@property(nonatomic, copy) NSString *group;

/**
* The parameter value.
*/
@property(nonatomic, copy) NSString *item;

/**
*   Creates and return a Custom Parameter object.
*
*   @param group Parameter name (e.g. "campaign, "adspace" or "creative")
*   @param item  Parameter value
*
*   @return CxenseDMPCustomParameter object with the specified group and item set.
*/
+ (CxenseDMPCustomParameter *)parameterWithGroup:(NSString *)group
                                            item:(NSString *)item;

@end