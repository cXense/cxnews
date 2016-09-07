//
//  InterestsProcessingService.m
//  CxNews
//
//  Created by Anver Bogatov on 12.08.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "InterestsProcessingService.h"

@implementation InterestsProcessingService

+(NSArray<InterestModel *> *)processInterestsTree:(NSArray<InterestModel *> *)plainInterestsArray {
    NSMutableDictionary<NSString *, InterestModel *> *roots = [NSMutableDictionary new];
    NSMutableArray<InterestModel *> *secondLevel = [NSMutableArray array];
    NSMutableArray<InterestModel *> *thirdLevel = [NSMutableArray array];

    for (InterestModel *obj in plainInterestsArray) {
        switch ([self countSubstring:@"/" inString:obj.category]) {
            case 0:
                [roots setObject:obj forKey:obj.category];
                break;
            case 1:
                [secondLevel addObject:obj];
                [self handleSecondLevelInterest:obj roots:roots];
                break;
            case 2:
                [thirdLevel addObject:obj];
                break;
            default:
                NSLog(@"Unsupported interests level found: '%@'", obj.category);
                break;
        }
    }

    NSArray<InterestModel *> *sortedRoots = [[roots allValues] sortedArrayUsingSelector:@selector(compare:)];
    for (InterestModel *root in sortedRoots) {
        [self sortInterestModelChildren:root];
    }
    return sortedRoots;
}

+(void)sortInterestModelChildren:(InterestModel *)interest {
    if (interest.children) {
        [interest.children sortUsingSelector:@selector(compare:)];
        for (InterestModel *child in interest.children) {
            [self sortInterestModelChildren:child];
        }
    }
}

+(void)handleSecondLevelInterest:(InterestModel *)obj
                           roots:(NSMutableDictionary *)roots{
    NSRange range = [obj.category rangeOfString:@"/"];
    NSString *rootName = [obj.category substringToIndex:range.location];
    InterestModel *parent = roots[rootName];
    if (!parent.children) {
        parent.children = [NSMutableArray array];
    }
    [parent.children addObject:obj];
    [self trimInterestModelRootLevelName:obj];
}

+(void)trimInterestModelRootLevelName:(InterestModel *)model {
    NSRange range = [model.category rangeOfString:@"/"];
    NSString *secondLevelName = [model.category substringFromIndex:(range.location + 1)];
    model.category = [NSString stringWithFormat:@"%@", secondLevelName];
}

+(NSUInteger)countSubstring:(NSString *)substring
                   inString:(NSString *)string {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:substring options:NSRegularExpressionCaseInsensitive error:&error];
    return [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
}


@end
