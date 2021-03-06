//
//  JCSegmentBar.m
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCSegmentBar.h"
#import "JCSegmentBarItemView.h"
#import "JCSegmentBarController.h"

@interface JCSegmentBar ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *itemBottomLineView;
@property (nonatomic, strong) CALayer *barBottomLineLayer;

@property (nonatomic, weak) JCSegmentBarController *segmentBarController;

@property (nonatomic, copy) JCSegmentBarItemSelectedBlock selectedBlock;

@end

@implementation JCSegmentBar

static NSString * const reuseIdentifier = @"segmentBarItemId";

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        // for collectionView
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.customItemViewName = NSStringFromClass([JCSegmentBarItemView class]);
        self.barStyle = JCSegmentBarStyleLight;
        [self addSubview:self.itemBottomLineView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.barBottomLineLayer.frame = CGRectMake(0, self.frame.size.height-0.5, MAX(self.contentSize.width, [UIScreen mainScreen].bounds.size.width), 0.5);
    [self.layer addSublayer:self.barBottomLineLayer];
    
    self.itemBottomLineView.frame = [self itemBottomLineViewFrame];
    
    if (!self.segmentBarController) {
        self.segmentBarController = self.jc_viewController.childViewControllers.firstObject;
        [self.segmentBarController setValue:self forKey:@"segmentBar"];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.segmentBarController performSelectorOnMainThread:@selector(updateSelectedIndex:) withObject:@(self.selectedIndex) waitUntilDone:YES];
#pragma clang diagnostic pop
    }
}

- (void)segmentBarItemDidSelected:(JCSegmentBarItemSelectedBlock)selectedBlock {
    self.selectedBlock = selectedBlock;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.itemWidth, self.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    JCSegmentBarItem *item = self.items[indexPath.item];
    item.titleColor = (self.selectedIndex == indexPath.item) ? self.tintColor : self.unselectedTintColor;

    [cell setValue:item forKey:@"segmentBarItem"];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self segmentBarItemDidChange:indexPath];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.segmentBarController performSelectorOnMainThread:@selector(updateSelectedIndex:) withObject:@(self.selectedIndex) waitUntilDone:YES];
#pragma clang diagnostic pop
}


#pragma mark - setter/getter

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    
    self.itemBottomLineView.backgroundColor = _tintColor;
}

- (void)setBarStyle:(JCSegmentBarStyle)barStyle {
    _barStyle = barStyle;
    
    if (barStyle == JCSegmentBarStyleLight) {
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = [UIColor colorWithRed:48/255.0f green:51/255.0f blue:59/255.0f alpha:1];
        self.unselectedTintColor = [UIColor colorWithRed:155/255.0f green:157/255.0f blue:165/255.0f alpha:1];
    } else if (barStyle == JCSegmentBarStyleDark) {
        self.backgroundColor = [UIColor colorWithRed:48/255.0f green:51/255.0f blue:59/255.0f alpha:1];
        self.tintColor = [UIColor colorWithRed:219/255.0f green:177/255.0f blue:119/255.0f alpha:1];
        self.unselectedTintColor = [UIColor whiteColor];
    }
}

- (void)setItems:(NSArray<JCSegmentBarItem *> *)items {
    _items = items;

    [self reloadData];
}

- (CALayer *)barBottomLineLayer {
    if (!_barBottomLineLayer) {
        _barBottomLineLayer = [CALayer layer];
        _barBottomLineLayer.backgroundColor = [UIColor colorWithRed:151/255.0f green:151/255.0f blue:151/255.0f alpha:1].CGColor;
    }
    
    return _barBottomLineLayer;
}

- (UIView *)itemBottomLineView {
    if (!_itemBottomLineView) {
        _itemBottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        _itemBottomLineView.layer.cornerRadius = 1.0f;
        _itemBottomLineView.layer.masksToBounds = YES;
        _itemBottomLineView.backgroundColor = self.tintColor;
    }
    
    return _itemBottomLineView;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex < 0 || selectedIndex >= self.items.count) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setCustomItemViewName:(NSString *)customItemViewName {
    _customItemViewName = customItemViewName;
    
    [self registerClass:[NSClassFromString(self.customItemViewName) class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - private

- (CGRect)itemBottomLineViewFrame {
    return CGRectMake(self.selectedIndex * self.itemWidth + ((self.itemWidth - self.itemBottomLineWidth)/2), self.frame.size.height-2, self.itemBottomLineWidth, 2);
}

- (void)segmentBarItemDidChange:(NSIndexPath *)selectedIndexPath {
    UICollectionViewCell *prevCell = [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    JCSegmentBarItem *prevItem = self.items[self.selectedIndex];
    prevItem.titleColor = self.unselectedTintColor;
    [prevCell setValue:prevItem forKey:@"segmentBarItem"];
    
    UICollectionViewCell *currentCell = [self cellForItemAtIndexPath:selectedIndexPath];
    JCSegmentBarItem *currentItem = self.items[selectedIndexPath.item];
    currentItem.titleColor = self.tintColor;
    [currentCell setValue:currentItem forKey:@"segmentBarItem"];
    
    [self reloadData];
    
    self.selectedIndex = selectedIndexPath.item;
    
    if (self.selectedBlock) {
        self.selectedBlock(self.selectedIndex);
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.itemBottomLineView.frame = [self itemBottomLineViewFrame];
    }];
}

- (UIViewController *)jc_viewController {
    UIResponder *responder = [self nextResponder];
    
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *) responder;
        }
        
        responder = [responder nextResponder];
    }
    
    return nil;
}

@end
