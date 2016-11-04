//
//  NewsDataSourceDelegate.h
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;

@protocol NewsDataSourceDelegate <NSObject>

-(void)newsDataSourceWasUpdated;

@end
