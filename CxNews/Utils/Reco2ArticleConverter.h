//
//  Reco2ArticleConverter.h
//  CxNews
//
//  Created by Anver Bogatov on 19/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ArticleModel.h"
#import "CxenseContentRecommendation.h"

@interface Reco2ArticleConverter : NSObject

+ (NSArray<ArticleModel *> *) articlesFromRecommendations:(NSArray<CxenseContentRecommendation *> *)recos;

+ (ArticleModel *)articleFromRecommendation:(CxenseContentRecommendation *)reco;

@end
