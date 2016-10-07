//
//  Reco2ArticleConverter.h
//  CxNews
//
//  Created by Anver Bogatov on 19/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//
@import Foundation;
@class ArticleModel, CxenseContentRecommendation;

@interface Reco2ArticleConverter : NSObject

/**
 Convert array of Cxense Content Recommendation instances to internal representation - ArticleModel.

 @param recos recommendation items received from Cxense Content

 @return array of article models that are internal representation of reco items
 */
+ (NSArray<ArticleModel *> *)articlesFromRecommendations:(NSArray<CxenseContentRecommendation *> *)recos;

/**
 Convert Cxense Content Recommendation instance to internal representation - ArticleModel.

 @param reco recommendation item received from Cxense Content

 @return internal representation of provided recommendation item
 */
+ (ArticleModel *)articleFromRecommendation:(CxenseContentRecommendation *)reco;

@end
