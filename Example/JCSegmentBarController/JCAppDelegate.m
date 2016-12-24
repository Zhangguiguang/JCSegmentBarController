//
//  JCAppDelegate.m
//  JCSegmentBarController
//
//  Created by 李京城 on 04/23/2015.
//  Copyright (c) 2014 lijingcheng. All rights reserved.
//

#import "JCAppDelegate.h"
#import "JCTableViewController.h"
#import "JCSegmentBarController.h"

@interface JCAppDelegate ()<JCSegmentBarControllerDelegate>

@end

@implementation JCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JCTableViewController *vc1 = [[JCTableViewController alloc] init];
    vc1.title = @"fruit";
    vc1.badgeValue = @"2";
    JCTableViewController *vc2 = [[JCTableViewController alloc] init];
    vc2.title = @"apple";
    vc2.badgeValue = @"3";
    JCTableViewController *vc3 = [[JCTableViewController alloc] init];
    vc3.title = @"banana";
    vc3.badgeValue = @"1";
    JCTableViewController *vc4 = [[JCTableViewController alloc] init];
    vc4.title = @"pomelo";
    JCTableViewController *vc5 = [[JCTableViewController alloc] init];
    vc5.title = @"orange";
    JCTableViewController *vc6 = [[JCTableViewController alloc] init];
    vc6.title = @"cherry";
    JCTableViewController *vc7 = [[JCTableViewController alloc] init];
    vc7.title = @"grape";
    JCTableViewController *vc8 = [[JCTableViewController alloc] init];
    vc8.title = @"lemon";
    
    JCSegmentBarController *segmentBarController = [[JCSegmentBarController alloc] initWithViewControllers:@[vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8]];
    segmentBarController.title = @"JCSegmentBarController";
    segmentBarController.delegate = self;
    segmentBarController.selectedIndex = 3;
    segmentBarController.segmentBar.selectedFont = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    segmentBarController.segmentBar.unSelectedFont = [UIFont systemFontOfSize:11 weight:UIFontWeightLight];
//    segmentBarController.segmentBar.barTintColor = [UIColor yellowColor];
//    segmentBarController.segmentBar.tintColor = [UIColor blueColor];
//    segmentBarController.segmentBar.selectedTintColor = [UIColor purpleColor];
//    segmentBarController.segmentBar.height = 50.0f;
//    segmentBarController.segmentBar.translucent = NO;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:segmentBarController];
    nav.navigationBar.barTintColor = [UIColor orangeColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    tabBarController.viewControllers = @[nav];
//    self.window.rootViewController = tabBarController;
    
    NSLog(@"\n\n🍀🍀🍀 The warnings in the console can be ignored, the actual use of lib will not exist. 🍀🍀🍀\n\n");
    
    return YES;
}

#pragma mark - JCSegmentBarControllerDelegate

- (void)segmentBarController:(JCSegmentBarController *)segmentBarController didSelectItem:(JCSegmentBarItem *)item {
    NSLog(@"%s: selectedIndex: %ld,title: %@", __func__, (long)segmentBarController.selectedIndex, item.title);
}

@end
