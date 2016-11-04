//
//  NewsModel.h
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property NSString *timestamp;
@property NSString *headline;

+(instancetype)newsModelWith:(NSString *)timestamp
                         and:(NSString *)headline;

@end
