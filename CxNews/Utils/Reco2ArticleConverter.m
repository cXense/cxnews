//
//  Reco2ArticleConverter.m
//  CxNews
//
//  Created by Anver Bogatov on 19/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "Reco2ArticleConverter.h"

@implementation Reco2ArticleConverter

+ (NSArray<ArticleModel *> *)articlesFromRecommendations:(NSArray<CxenseContentRecommendation *> *)recos {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:recos.count];
    for (CxenseContentRecommendation *reco in recos) {
        [result addObject:[Reco2ArticleConverter articleFromRecommendation:reco]];
    }
    return result;
}

+ (ArticleModel *)articleFromRecommendation:(CxenseContentRecommendation *)reco {
    ArticleModel *model = [[ArticleModel alloc] init];
    model.imageUrl = [reco data][@"dominantthumbnail"];
    model.headline = [reco data][@"title"];
    model.clickUrl = reco.clickUrl;
    model.url = reco.url;
    model.timestamp = reco.data[@"body"][1];
    model.section = reco.data[@"body"][0];
    return model;
}

@end
