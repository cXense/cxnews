//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CxenseDMPProfile : NSObject

/**
* Array of CxenseDMPGroup objects associated with the item.
*/
@property (nonatomic, copy) NSArray *groups;

/**
* The item which is to be associated with the groups.
*/
@property (nonatomic, copy) NSString *item;

/**
* Creates and returns a CxenseDMPProfile object with the specified groups and item set.
*
* @param group Array of CxenseDMPGroup objects associated with the item.
* @param item  The item which is to be associated with the groups.
*
* @return CxenseDMPProfile with specified groups and item set.
*/
+ (CxenseDMPProfile *)profileWithGroup:(NSArray *)groups andItem:(NSString *)item;

@end