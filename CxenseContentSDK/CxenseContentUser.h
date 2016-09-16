//
//  CxenseContentUser.h
//  CxenseContent
//
//  Copyright (c) 2015 Cxense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CxenseContentUser : NSObject <NSCopying>

/**
 *  Dictionary of IDs (key-value where id-type is key, and the id is value)
 */
@property(nonatomic, strong) NSDictionary *ids;

/**
 *  Array of likes
 */
@property(nonatomic, strong) NSArray *likes;

/**
 *  Array of dislikes
 */
@property(nonatomic, strong) NSArray *dislikes;

+ (instancetype)userWithIds:(NSDictionary *)ids
                      likes:(NSArray *)likes
                   dislikes:(NSArray *)dislikes;

@end
