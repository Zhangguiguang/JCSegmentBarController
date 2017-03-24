//
//  JCAppDelegate.m
//  JCSegmentBarController
//
//  Created by 李京城 on 04/23/2015.
//  Copyright (c) 2014 lijingcheng. All rights reserved.
//

#import "JCAppDelegate.h"
#import "JCMainViewController.h"

@implementation JCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JCMainViewController *mainVC = [[JCMainViewController alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"\n\n🍀🍀🍀 The warnings in the console can be ignored, the actual use of lib will not exist. 🍀🍀🍀\n\n");
    
    return YES;
}

@end
