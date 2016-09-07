//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CxenseDMPEvent.h"

@interface CxenseDMPExternalProfile : NSObject <CxenseDMPDictionaryRepresentation>

/**
* The group name. It is required that the group name starts with the Customer Prefix ('type'),
* followed by dash (e.g. xyz-groupname).
*/
@property (nonatomic, copy) NSString *group;

/**
* The item which is to be associated with the group name.
*/
@property (nonatomic, copy) NSString *item;

/**
* Creates and returns a CxenseDMPProfile object with the specified group and item set.
*
* @param group The group name. It is required that the group name starts with the Customer
*                Prefix ('type'), followed by dash (e.g. xyz-groupname).
*
* @param item  The item which is to be associated with the group name.
*
* @return CxenseDMPExternalProfile with specified group and item set.
*/
+ (CxenseDMPExternalProfile *)profileWithGroup:(NSString *)group andItem:(NSString *)item;

@end