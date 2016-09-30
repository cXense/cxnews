//
//  VideoService.h
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"

typedef void(^VideoServiceCompletion)(NSArray<VideoModel *> *videos, NSError *error);

/**
 VideoService is responsible for loading descriptors of 
 all currently available videos on web site.
 */
@interface VideoService : NSObject

/**
 Returns descriptors of all videos available to play.

 @return array with video models
 */
-(void)availableVideosWithCompleteion:(VideoServiceCompletion)completion;


/**
 Extracts exact url that points to video content from specified page with video.

 @param videoPageUrl URL that points to page with video

 @return video url
 */
-(NSString *)urlWithVideoFromPage:(NSString *)videoPageUrl;

/**
 Returns initialized instance of the service.

 @return instance
 */
+(instancetype)sharedInstance;

@end
