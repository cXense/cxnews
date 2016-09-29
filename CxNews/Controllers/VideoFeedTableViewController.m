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

@implementation VideoFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    VideoService *videoSerivce = [VideoService sharedInstance];
    [videoSerivce availableVideosWithCompleteion:^(NSArray<VideoModel *> *videos, NSError *error) {
        if (error != nil) {
            NSLog(@"Error appeared during videos load: %@", [error description]);
        }

        
    }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"video_cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:kCxenseVideoFeedTableViewCellImageTag];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i2.cdn.turner.com/cnn/dam/assets/150103043419-nr-stevens-two-large-metal-objects-00030211-t3-entertainment.jpg"]]];

    UILabel *title = [cell viewWithTag:kCxenseVideoFeedTableViewCellTitleTag];
    title.alpha = 1.0;
    title.text = @"AirAsia search thwarted by rough seas";

    UILabel *timestamp = [cell viewWithTag:kCxenseVideoFeedTableViewCellTimestampTag];
    timestamp.alpha = 1.0;
    timestamp.text = @"1/3/2015 9:37:41 AM";
    
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
