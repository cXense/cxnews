//
//  InterestsViewController.m
//  CxNews
//
//  Created by Anver Bogatov on 29/07/2016.
//  Copyright © 2016 Anver Bogatov. All rights reserved.
//

#import "InterestsViewController.h"
#import "UserService.h"
#import "CXNEventsService.h"
#import "UserProfileService.h"
#import "UIViewController+Indicator.h"

@interface InterestsViewController ()

@property (weak, nonatomic) IBOutlet HorizontalBarChartView *chartView;

@end

@implementation InterestsViewController

#pragma mark UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"Long Term Interests"];
    [self configureChartView];
    [self showActivityIndicator];
    [[UserProfileService sharedInstance] loadInterestsForUserWithExternalId:[[UserService sharedInstance] userProfileId]
                                                             withCompletion:^(NSArray<InterestModel *> *interests) {
                                                                 NSLog(@"Found %lu interests", (unsigned long)interests.count);
                                                                 [self updateChartModel:interests];
                                                                 [self dismissActivityIndicator];
                                                             }];

    [[CXNEventsService sharedInstance] trackEventWithName:@"Chart View"
                                          forPageWithName:@"Long Term Interests"
                                                   andUrl:@"https://cxnews.azurewebsites.net/long-term-interests"
                                          andRefferingUrl:@"https://cxnews.azurewebsites.net/profileinterests"
                                        byTrackerWithName:@"LTI"];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[CXNEventsService sharedInstance] trackActiveTimeOfEventWithName:@"Chart View"
                                                          trackerName:@"LTI"];
}

#pragma mark Initialization

-(void)configureChartView {
    self.chartView.leftAxis.enabled = NO;
    self.chartView.rightAxis.enabled = NO;
    self.chartView.userInteractionEnabled = NO;
    self.chartView.drawBarShadowEnabled = NO;
    self.chartView.maxVisibleValueCount = 100;
    self.chartView.legend.enabled = NO;
    self.chartView.gridBackgroundColor = [UIColor grayColor];
    self.chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    self.chartView.xAxis.drawGridLinesEnabled = NO;
    self.chartView.xAxis.drawAxisLineEnabled = NO;
    self.chartView.xAxis.drawLimitLinesBehindDataEnabled = NO;
    [self.chartView setDescriptionText:@""];
    [self.chartView animateWithYAxisDuration:1.5];
}

-(void)updateChartModel:(NSArray<InterestModel *> *)interests {
    if (interests.count == 0) {
        self.chartView.data = nil;
        return;
    }

    NSMutableArray *xVals = [NSMutableArray array];
    NSMutableArray *yVals = [NSMutableArray array];
    NSMutableArray *colors = [NSMutableArray array];
    int cnt = 0;
    for (InterestModel *interest in interests) {
        // BarChartDataSet will be rendered in reverse order, that's why we need to add children first
        if (interest.children) {
            for (InterestModel *child in interest.children) {
                [colors addObject:[UIColor colorWithRed:0.64 green:0.89 blue:1.00 alpha:1.0]];
                [xVals addObject:child.category];
                [yVals addObject:[[BarChartDataEntry alloc] initWithValue:child.weight xIndex:cnt]];
                cnt++;
            }
        }
        [colors addObject:[UIColor colorWithRed:0.33 green:0.79 blue:0.99 alpha:1.0]];
        [xVals addObject:interest.category];
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:interest.weight xIndex:cnt]];
        cnt++;
    }

    BarChartDataSet *set = [[BarChartDataSet alloc] initWithYVals:yVals label:@"Interests"];
    set.barSpace = 0.35;
    set.colors = colors;

    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:@[set]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];

    self.chartView.data = data;
}

@end
