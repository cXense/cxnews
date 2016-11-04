//
//  NewsRowController.h
//  CxNews
//
//  Created by Anver Bogatov on 04.11.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;
@import WatchKit;

@interface NewsRowController : NSObject
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *timestampLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *headlineLabel;
@end
