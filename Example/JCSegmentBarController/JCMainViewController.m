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

    [self useDefaultSegmentBarItemView];
    
//    [self useCustomSegmentBarItemView];
}

- (void)useCustomSegmentBarItemView {
    JCSegmentBarItem *item1 = [[JCSegmentBarItem alloc] initWithTitle:@"绑定会员卡" image:[UIImage imageNamed:@"mine_wallet_card"]];
    JCSegmentBarItem *item2 = [[JCSegmentBarItem alloc] initWithTitle:@"绑定优惠券" image:[UIImage imageNamed:@"mine_wallet_coupon"]];
    
    JCSegmentBar *segmentBar = [[JCSegmentBar alloc] initWithFrame:CGRectMake(10, 56, [UIScreen mainScreen].bounds.size.width - 20, 85)];
    segmentBar.customItemViewName = @"JCSegmentBarItemCustomView"; ////////////
    segmentBar.items = @[item1, item2];
    segmentBar.itemWidth = (segmentBar.frame.size.width)/2;

    [self.view addSubview:segmentBar];
    
    // add segment controller
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor orangeColor];
    
    JCSegmentBarController *segmentBarController = [[JCSegmentBarController alloc] initWithViewControllers:@[vc1, vc2]];
    segmentBarController.view.frame = CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width - 20, 300);
    [self addChildViewController:segmentBarController];
    [self.view addSubview:segmentBarController.view];
    [segmentBarController didMoveToParentViewController:self];
}

- (void)useDefaultSegmentBarItemView {
    JCSegmentBarItem *item1 = [[JCSegmentBarItem alloc] initWithTitle:@"今天"];
    item1.badgeValue = @"惠";
    JCSegmentBarItem *item2 = [[JCSegmentBarItem alloc] initWithTitle:@"明天"];
    JCSegmentBarItem *item3 = [[JCSegmentBarItem alloc] initWithTitle:@"后天"];
    
    JCSegmentBar *segmentBar = [[JCSegmentBar alloc] initWithFrame:CGRectMake(10, 56, [UIScreen mainScreen].bounds.size.width - 20, 44)];
    segmentBar.barStyle = JCSegmentBarStyleDark;
    segmentBar.items = @[item1, item2, item3, item2, item3, item2, item3];
    segmentBar.itemWidth = 100;
    segmentBar.itemBottomLineWidth = 70;
    segmentBar.selectedIndex = 1;
    
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
    segmentBarController.selectedIndex = segmentBar.selectedIndex;
    [self addChildViewController:segmentBarController];
    [self.view addSubview:segmentBarController.view];
    [segmentBarController didMoveToParentViewController:self];
}

@end
