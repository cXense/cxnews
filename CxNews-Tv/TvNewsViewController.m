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

@interface TvNewsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ibLeftNewsButton;
@property (weak, nonatomic) IBOutlet UIButton *ibCenterNewsButton;
@property (weak, nonatomic) IBOutlet UIButton *ibRightNewsButton;
@property (weak, nonatomic) IBOutlet UIScrollView *ibScrollBiew;
@end

@implementation TvNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize newSize = CGSizeMake(2220, self.ibScrollBiew.contentSize.height);
    self.ibScrollBiew.contentSize = newSize;
    
    VideoService *videoService = [VideoService sharedInstance];
    NSLog(@"Requesting videos from VideoService");
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
