//
//  NSString+HTML.h
//  CxNews
//
//  Created by Anver Bogatov on 06.10.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

@import Foundation;


/**
 NSString category that helps encode / decode URLs and HTMLs.
 Full source code can be found here: https://github.com/Koolistov/NSString-HTML
 */
@interface NSString (HTML)

- (NSString *)kv_decodeHTMLCharacterEntities;

@end
