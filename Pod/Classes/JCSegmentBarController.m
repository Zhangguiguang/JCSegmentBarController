//
//  JCSegmentBarController.m
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCSegmentBarController.h"
#import <objc/runtime.h>

NSString *const kJCPageControllerDidChangeNotification = @"kJCPageControllerDidChangeNotification";

@interface JCSegmentBarController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, copy) NSArray<UIViewController *> *pageContent;

@property (nonatomic, strong) id notificationObserver;

@end

@implementation JCSegmentBarController

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers {
    if (self = [super init]) {
        self.pageContent = viewControllers;
        
        self.notificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kJCSegmentItemDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            self.selectedIndex = [note.userInfo[@"selectIndex"] integerValue];
            NSLog(@"JCSegmentBarController    %ld", self.selectedIndex);
        }];
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.notificationObserver];
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
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kJCPageControllerDidChangeNotification object:nil userInfo:@{@"selectIndex": @(self.selectedIndex)}];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

#pragma mark - setter/getter

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex < 0 || selectedIndex >= self.pageContent.count) {
        return;
    }
    
    NSInteger direction = (_selectedIndex > selectedIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
    
    _selectedIndex = selectedIndex;
    
    [self.pageController setViewControllers:@[self.pageContent[selectedIndex]] direction:direction animated:YES completion:nil];
}

- (UIPageViewController *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.frame = self.view.bounds;
        [_pageController setViewControllers:@[self.pageContent[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    
    return _pageController;
}

#pragma mark -


- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated {
//    if (index >= 0 && index < self.viewControllers.count && (index != self.selectedIndex || !self.selectedItem)) {
//        JCSegmentBarItem *item = (JCSegmentBarItem *)[self.segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
//        
//        [self selected:item unSelected:self.selectedItem];
//        
//        [self adjustSegmentBarContentOffset:index];
//      
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
//
//        if (self.didSeletedController) {
//            self.didSeletedController(self.selectedViewController);
//        }
//    }
}

- (void)selected:(JCSegmentBarItem *)selectedItem unSelected:(JCSegmentBarItem *)unSelectedItem {
//    selectedItem.titleLabel.textColor = self.segmentBar.selectedTintColor;
//    selectedItem.titleLabel.font = self.segmentBar.selectedFont;
//    
//    unSelectedItem.titleLabel.textColor = self.segmentBar.tintColor;
//    unSelectedItem.titleLabel.font = self.segmentBar.unSelectedFont;
//    
//    CGFloat duration = unSelectedItem ? 0.3f : 0.0f;
//    
//    [UIView animateWithDuration:duration animations:^{
//        selectedItem.transform = CGAffineTransformMakeScale(1.1, 1.1);
//        unSelectedItem.transform = CGAffineTransformIdentity;
//        
//        CGRect frame = self.segmentBar.bottomLineView.frame;
//        frame.origin.x = selectedItem.frame.origin.x + (selectedItem.frame.size.width - self.segmentBar.bottomLineView.frame.size.width)/2;
//        self.segmentBar.bottomLineView.frame = frame;
//    }];
//    
//    _selectedIndex = selectedItem.tag;
//    self.selectedItem = selectedItem;
//    self.selectedViewController = self.viewControllers[self.selectedIndex];
}

- (void)adjustSegmentBarContentOffset:(NSInteger)index {
//    if (self.viewControllers.count > self.itemCount) {
//        CGFloat itemWidth = [UIScreen mainScreen].bounds.size.width/self.itemCount;
//        CGFloat offsetX = 0;
//        
//        if (index <= floor(self.itemCount/2)) {
//            offsetX = 0;
//        }
//        else if (index >= (self.viewControllers.count - ceil(self.itemCount/2))) {
//            offsetX = (self.viewControllers.count - self.itemCount) * itemWidth;
//        }
//        else {
//            offsetX = (index - floor(self.itemCount/2)) * itemWidth;
//        }
//        
//        [self.segmentBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
//    }
}

@end
