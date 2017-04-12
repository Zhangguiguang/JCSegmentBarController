//
//  JCSegmentBarController.h
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCSegmentBar.h"
#import "JCSegmentBarItem.h"
#import "JCSegmentBarItemView.h"

@interface JCSegmentBarController : UIViewController

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers;

@end
