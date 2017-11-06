//
//  Reco2ArticleConverter.m
//  CxNews
//
//  Created by Anver Bogatov on 19/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "Reco2ArticleConverter.h"
#import "ArticleModel.h"
#import "ATS-URL-Converter.h"

@import CxenseSDK;

@implementation Reco2ArticleConverter

+ (NSArray<ArticleModel *> *)articlesFromRecommendations:(NSArray<ContentRecommendation *> *)recos {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:recos.count];
    for (ContentRecommendation *reco in recos) {
        [result addObject:[Reco2ArticleConverter articleFromRecommendation:reco]];
    }
    return result;
}

+ (ArticleModel *)articleFromRecommendation:(ContentRecommendation *)reco {
    ArticleModel *model = [[ArticleModel alloc] init];
    model.imageUrl = reco.dominantthumbnail;
    model.headline = reco.title;
    model.clickUrl = [ATS_URL_Converter convertToHttps:reco.clickUrl];
    model.url = [ATS_URL_Converter convertToHttps:reco.url];
    model.timestamp = reco.data[1];
    model.section = reco.data[0];
    return model;
}

@end
