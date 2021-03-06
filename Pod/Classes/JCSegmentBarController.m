//
//  JCSegmentBarController.m
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCSegmentBarController.h"
#import "JCSegmentBar.h"

@interface JCSegmentBarController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, copy) NSArray<UIViewController *> *pageContent;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) JCSegmentBar *segmentBar;

@end

@implementation JCSegmentBarController

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
    if (self = [super init]) {
        self.pageContent = viewControllers;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:227/255.0f green:229/255.0f blue:237/255.0f alpha:1];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
}

#pragma mark - UIPageViewControllerDelegate & UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.pageContent indexOfObject:viewController];;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return self.pageContent[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.pageContent indexOfObject:viewController];;
   
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == self.pageContent.count) {
        return nil;
    }
    
    return self.pageContent[index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        _selectedIndex = [self.pageContent indexOfObject:[pageViewController.viewControllers lastObject]];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.segmentBar performSelectorOnMainThread:@selector(segmentBarItemDidChange:) withObject:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] waitUntilDone:YES];
#pragma clang diagnostic pop
    }
}

#pragma mark - setter/getter

- (void)updateSelectedIndex:(NSNumber *)selectedIndex {
    self.selectedIndex = selectedIndex.integerValue;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex < 0 || selectedIndex >= self.pageContent.count) {
        return;
    }
    
    NSInteger direction = (_selectedIndex > selectedIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
    
    _selectedIndex = selectedIndex;

    __weak JCSegmentBarController *safeSelf = self;
    [self.pageController setViewControllers:@[self.pageContent[selectedIndex]] direction:direction animated:YES completion:^(BOOL finished) {
        if (finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [safeSelf.pageController setViewControllers:@[safeSelf.pageContent[selectedIndex]] direction:direction animated:NO completion:nil];
            });
        }
    }];
}

- (UIPageViewController *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.frame = self.view.bounds;
        [_pageController setViewControllers:@[self.pageContent[self.selectedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
    return _pageController;
}

@end
