//
//  JCSegmentBar.h
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JCSegmentBarStyle) {
    JCSegmentBarStyleLight,
    JCSegmentBarStyleDark,
    JCSegmentBarStyleCustom
};

@class JCSegmentBarItem;
typedef void (^JCSegmentBarItemSelectedBlock)(NSInteger index);

@interface JCSegmentBar : UICollectionView

@property (nonatomic, assign) JCSegmentBarStyle barStyle;

@property (nonatomic, copy) NSString *customItemViewName;

@property (nonatomic, copy) NSArray<JCSegmentBarItem *> *items;

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemBottomLineWidth;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *unselectedTintColor;

- (void)segmentBarItemDidSelected:(JCSegmentBarItemSelectedBlock)selectedBlock;

@end
