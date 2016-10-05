//
//  InterestsProcessingService.h
//  CxNews
//
//  Created by Anver Bogatov on 12.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;

@class InterestModel;

@interface InterestsProcessingService : NSObject

/**
 Process plain list of interest models before showing it in UI.
 Trim all sub-levels of interests more than 3 (other sub-levels are not
 presentable on the screen) and sort them by levels.

 @param plainInterestsArray list of interest models resolved from API

 @return processed and sorted list of interest models
 */
+(NSArray<InterestModel *> *)processInterestsTree:(NSArray<InterestModel *> *)plainInterestsArray;

@end
