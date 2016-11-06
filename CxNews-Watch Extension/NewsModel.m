//
//  NewsModel.m
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+(instancetype)newsModelWith:(NSString *)timestamp
                         and:(NSString *)headline {
    NewsModel *model = [NewsModel new];
    model.timestamp = timestamp;
    model.headline = headline;
    return model;
}

@end
