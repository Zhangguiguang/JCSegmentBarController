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

NSString *const kJCSegmentItemDidChangeNotification = @"kJCSegmentItemDidChangeNotification";

@interface JCSegmentBar ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *itemBottomLineView;

@property (nonatomic, copy) JCSegmentBarItemSeletedBlock seletedBlock;

@property (nonatomic, strong) id notificationObserver;

@end

@implementation JCSegmentBar

static NSString * const reuseIdentifier = @"segmentBarItemId";

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        // add bottom border line
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0, self.frame.size.height-0.5, self.contentSize.width, 0.5);
        bottomBorder.backgroundColor = [UIColor colorWithRed:151/255.0f green:151/255.0f blue:151/255.0f alpha:1].CGColor;
        [self.layer addSublayer:bottomBorder];
        
        // for collectionView
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[JCSegmentBarItemView class] forCellWithReuseIdentifier:reuseIdentifier];
        
        // other settings
        self.barStyle = JCSegmentBarStyleDark;

        [self addSubview:self.itemBottomLineView];
        
        self.notificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:kJCPageControllerDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            self.selectedIndex = [note.userInfo[@"selectIndex"] integerValue];
            [self reloadData];
            [UIView animateWithDuration:0.3f animations:^{
                self.itemBottomLineView.frame = [self itemBottomLineViewFrame];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.itemBottomLineView.frame = [self itemBottomLineViewFrame];
}

- (void)didSeletedSegmentBarItem:(JCSegmentBarItemSeletedBlock)seletedBlock {
    self.seletedBlock = seletedBlock;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.itemWidth, self.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JCSegmentBarItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    JCSegmentBarItem *item = self.items[indexPath.item];
    NSLog(@"___%ld,%ld", self.selectedIndex, indexPath.item);
    if (self.selectedIndex == indexPath.item) {
        item.titleAttributes = @{NSForegroundColorAttributeName: self.tintColor};
    } else {
        item.titleAttributes = @{NSForegroundColorAttributeName: self.unselectedTintColor};
    }
    
    cell.segmentBarItem = item;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.item;
     [collectionView reloadData];
    [UIView animateWithDuration:0.3f animations:^{
        self.itemBottomLineView.frame = [self itemBottomLineViewFrame];
    } completion:^(BOOL finished) {
       
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kJCSegmentItemDidChangeNotification object:nil userInfo:@{@"selectIndex": @(self.selectedIndex)}];
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

- (CGRect)itemBottomLineViewFrame {
    return CGRectMake(self.selectedIndex * self.itemWidth + ((self.itemWidth - self.itemBottomLineWidth)/2), self.frame.size.height-2, self.itemBottomLineWidth, 2);
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex < 0 || selectedIndex >= self.items.count) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    //- (void)setItems:(NSArray<UITabBarItem *> *)items animated:(BOOL)animated;
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

@end
