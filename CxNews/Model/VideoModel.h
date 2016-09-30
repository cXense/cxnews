//
//  VideoModel.h
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Represents video item in the application.
 */
@interface VideoModel : NSObject

/**
 String with URL that points to page with video player.
 */
@property NSString *videoPageUrl;

/**
 String with URL that points to video's thumbnail image.
 */
@property NSString *imageUrl;

/**
 Title of the video.
 */
@property NSString *title;

/**
 Timestamp of the video.
 */
@property NSString *timestamp;

@end
