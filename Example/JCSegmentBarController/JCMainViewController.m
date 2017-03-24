//
//  JCMainViewController.m
//  JCSegmentBarController
//
//  Created by 李京城 on 2017/3/18.
//  Copyright © 2017年 lijingcheng. All rights reserved.
//

#import "JCMainViewController.h"
#import "JCSegmentBarController.h"

@implementation JCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    // add segment bar
    JCSegmentBarItem *item1 = [[JCSegmentBarItem alloc] initWithTitle:@"fruit"];
    item1.badgeValue = @"惠";
    JCSegmentBarItem *item2 = [[JCSegmentBarItem alloc] initWithTitle:@"apple"];
    JCSegmentBarItem *item3 = [[JCSegmentBarItem alloc] initWithTitle:@"banana"];
    
    NSArray<JCSegmentBarItem *> *items = @[item1, item2, item3];
    
    
    
    JCSegmentBar *segmentBar = [[JCSegmentBar alloc] initWithFrame:CGRectMake(10, 56, [UIScreen mainScreen].bounds.size.width - 20, 44)];
    segmentBar.selectedIndex = 2;
    //    segmentBarController.segmentBar.barTintColor = [UIColor yellowColor];
    //    segmentBarController.segmentBar.tintColor = [UIColor blueColor];
    //    segmentBarController.segmentBar.selectedTintColor = [UIColor purpleColor];
    segmentBar.itemWidth = 100;
    segmentBar.itemBottomLineWidth = 70;
    segmentBar.items = items;
    [self.view addSubview:segmentBar];
    
    // add segment controller
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor orangeColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor darkGrayColor];
    
    JCSegmentBarController *segmentBarController = [[JCSegmentBarController alloc] initWithViewControllers:@[vc1, vc2, vc3]];
    segmentBarController.view.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 300);
    
    [self addChildViewController:segmentBarController];
    [self.view addSubview:segmentBarController.view];
    [segmentBarController didMoveToParentViewController:self];
}

@end
