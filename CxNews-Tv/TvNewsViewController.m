//
//  TvNewsViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 21.04.17.
//  Copyright © 2017 Anver Bogatov. All rights reserved.
//

#import "TvNewsViewController.h"
#import "VideoService.h"
#import "VideoModel.h"
#import "CxenseInsight.h"

@interface TvNewsViewController ()

@end

@implementation TvNewsViewController {
    CxenseInsightTracker *_tracker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init insight tracker. (EventService is not used here in example purpose).
    _tracker = [CxenseInsight trackerWithName:@"tvTracker" siteId:@"1145195936689130309"];
    
    CxenseInsight.dispatchMode = CxenseInsightDispatchModeOnline;
    NSLog(@"UA = %@", [CxenseInsight userAgent]);
    
    
    // Video section of the site is not available at the moment.
//    VideoService *videoService = [VideoService sharedInstance];
//    NSLog(@"Requesting videos from VideoService");
    //    [videoService availableVideosWithCompleteion:^(NSSet<VideoModel *> *videos, NSError *error) {
    //        if (error) {
    //            NSLog(@"Error happened: %@", error.description);
    //        } else {
    //            _ibLeftNewsButton.titleLabel.text = videos.anyObject.title;
    //            _ibCenterNewsButton.titleLabel.text = videos.anyObject.title;
    //            _ibRightNewsButton.titleLabel.text = videos.anyObject.title;
    //        }
    //    }];
}

- (IBAction)tapOnButton:(UIButton *)sender {
    NSLog(@"Tap on %@", sender.currentTitle);
    [self reportEventToInsight:sender.currentTitle];
}

- (void)reportEventToInsight:(NSString *)title {
    CxenseInsightEventBuilder *builder = [CxenseInsightEventBuilder pageViewEventWithURL:@"https://www.google.ru" referringURL:@"https://www.google.ru" siteId:@"1145195936689130309"];
    [builder setCustomParameter:title forKey:@"title"];
    NSDictionary *eventData = [builder build];
    
    [_tracker trackEvent:eventData name:@"tv" completion:^(NSDictionary *event, NSError *error) {
        if (error) {
            NSLog(@"Error during event reporting: %@", error.description);
        } else {
            NSLog(@"Event with data = '%@' was reported", event);
        }
    }];
    [CxenseInsight dispatch];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
