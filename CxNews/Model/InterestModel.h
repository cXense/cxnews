//
//  InterestModel.h
//  CxNews
//
//  Created by Anver Bogatov on 02.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Represents user interests category with weight and children interest categories */
@interface InterestModel : NSObject

/** Interest category name */
@property NSString *category;

/** Interest category weight (percentage) */
@property float weight;

@property NSMutableArray<InterestModel *> *children;

-(instancetype)initWithCategory:(NSString *)category
                      andWeight:(float)weight;

@end
