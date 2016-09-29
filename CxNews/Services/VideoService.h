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
 Returns initialized instance of the service.

 @return instance
 */
+(instancetype)sharedInstance;

@end
