//
//  InterestModel.h
//  CxNews
//
//  Created by Anver Bogatov on 02.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;
@import CoreGraphics.CGBase;

/** Represents user interests category with weight and children interest categories */
@interface InterestModel : NSObject

/**
 Interest category name.
 */
@property NSString *category;

/**
 Interest category weight (percentage).
 */
@property CGFloat weight;

/**
 Children interest models.
 */
@property NSMutableArray<InterestModel *> *children;

/**
 Returns interest model instance initialized with
 specified parameters.

 @param category interest model's category
 @param weight   interest model's weight

 @return initialized instance of interest model
 */
-(instancetype)initWithCategory:(NSString *)category
                      andWeight:(CGFloat)weight;

@end
