//
// Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CxenseDMPGroup : NSObject

/**
* Represents the category or type of information.
*/
@property(nonatomic, copy) NSString *group;

/**
* The number of times the item/group combination was generated from the page content.
*/
@property(nonatomic) NSInteger count;

/**
* Indicates the relative prominence of the item/group combination.
*/
@property(nonatomic) double weight;

/**
* Creates and returns a CxenseDMPGroup object with the specified parameters set.
*
* @param group  Represents the category or type of information.
* @param count  The number of times the item/group combination was generated from the page content.
* @param weight Indicates the relative prominence of the item/group combination.
*
* @return CxenseDMPGroup object with specified parameters set.
*/
+ (CxenseDMPGroup *)groupWithGroup:(NSString *)group
                             count:(NSInteger)count
                            weight:(double)weight;

@end