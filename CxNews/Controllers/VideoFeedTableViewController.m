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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
