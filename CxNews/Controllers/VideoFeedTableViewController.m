//
//  VideoFeedTableViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 28.09.16.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "VideoFeedTableViewController.h"
#import "Constants.h"
#import "VideoService.h"
@import AVKit.AVPlayerViewController;
@import AVFoundation.AVPlayer;

@interface VideoFeedTableViewController ()

@end

@implementation VideoFeedTableViewController {
    NSArray<VideoModel *> *_videoRepository;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"Videos"];

    VideoService *videoSerivce = [VideoService sharedInstance];
    [videoSerivce availableVideosWithCompleteion:^(NSArray<VideoModel *> *videos, NSError *error) {
        if (error != nil) {
            NSLog(@"Error appeared during videos load: %@", [error description]);
        }

        _videoRepository = videos;
        [self.tableView reloadData];
    }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_videoRepository count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"video_cell" forIndexPath:indexPath];

    VideoModel *rowModel = _videoRepository[indexPath.row];

    UIImageView *imageView = [cell viewWithTag:kCxenseVideoFeedTableViewCellImageTag];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:rowModel.imageUrl]]];


    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                   initWithData:[rowModel.title dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                   documentAttributes:nil
                                                   error:nil];
    float fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? kCxenseTextContentFontSizeIPhone : kCxenseTextContentFontSizeIPad;
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:@"Helvetica Bold" size:fontSize]
                             range:NSMakeRange(0, attributedString.string.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor whiteColor]
                             range:NSMakeRange(0, attributedString.string.length)];

    UILabel *title = [cell viewWithTag:kCxenseVideoFeedTableViewCellTitleTag];
    title.alpha = 1.0;
    title.attributedText = attributedString;

    UILabel *timestamp = [cell viewWithTag:kCxenseVideoFeedTableViewCellTimestampTag];
    timestamp.alpha = 1.0;
    timestamp.text = rowModel.timestamp;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoModel *model = _videoRepository[indexPath.row];

    NSString *urlToVideoContent = [[VideoService sharedInstance] urlWithVideoFromPage:model.videoPageUrl];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Video" bundle:[NSBundle mainBundle]];
    AVPlayerViewController* playerVc = [storyboard instantiateViewControllerWithIdentifier:@"av_vc"];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:urlToVideoContent]];
    playerVc.player = player;

    [self presentViewController:playerVc animated:YES completion:nil];
}

@end
