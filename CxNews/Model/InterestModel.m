//
//  InterestModel.m
//  CxNews
//
//  Created by Anver Bogatov on 02.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "InterestModel.h"

@implementation InterestModel

-(instancetype)initWithCategory:(NSString *)category
                      andWeight:(CGFloat)weight {
    self = [super init];
    if (self) {
        self.category = category;
        self.weight = weight;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"InterestModel: name='%@' weight(%%)='%.2f' children='%@'", self.category, self.weight, self.children];
}

-(NSComparisonResult)compare:(InterestModel *)other {
    if (self.weight == other.weight) {
        return NSOrderedSame;
    } else if (self.weight < other.weight) {
        return NSOrderedAscending;
    } else {
        return NSOrderedDescending;
    }
}
@end
