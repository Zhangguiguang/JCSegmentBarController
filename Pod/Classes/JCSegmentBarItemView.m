//
//  JCSegmentBarItemView.m
//  JCSegmentBarController
//
//  Created by 李京城 on 2017/3/16.
//  Copyright (c) 2017年 李京城. All rights reserved.
//

#import "JCSegmentBarItemView.h"
#import "JCSegmentBarItem.h"

@interface JCSegmentBarItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation JCSegmentBarItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.badgeLabel];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.text = @"";
    self.badgeLabel.text = @"";
    self.badgeLabel.hidden = YES;
}

#pragma mark - setter/getter

- (void)setSegmentBarItem:(JCSegmentBarItem *)segmentBarItem {
    _segmentBarItem = segmentBarItem;
    
    self.titleLabel.text = segmentBarItem.title;
    self.titleLabel.textColor = segmentBarItem.titleColor;
    [self.titleLabel sizeToFit];

    self.badgeLabel.text = segmentBarItem.badgeValue;
    self.badgeLabel.hidden = !(segmentBarItem.badgeValue && ![segmentBarItem.badgeValue isEqualToString:@""]);
    
    [self updateTitleAndBadgeFrame];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLabel;
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.layer.cornerRadius = 8.0f;
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.font = [UIFont systemFontOfSize:10];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = [UIColor colorWithRed:253/255.0f green:146/255.0f blue:103/255.0f alpha:1];
    }
    
    return _badgeLabel;
}

#pragma mark -

- (void)updateTitleAndBadgeFrame {
    CGFloat titleWidth = ceil(self.titleLabel.frame.size.width);
    CGFloat titleHeight = ceil(self.titleLabel.frame.size.height);
    
    CGRect titleRect = CGRectMake((self.bounds.size.width-titleWidth)/2, (self.bounds.size.height-titleHeight)/2, titleWidth, titleHeight);
    
    if (!self.badgeLabel.hidden) {
        titleRect.origin.x -= 10;
        
        self.badgeLabel.frame = CGRectMake(CGRectGetMaxX(titleRect) + 4, (self.bounds.size.height-16)/2, 16, 16);
    }
    
    self.titleLabel.frame = titleRect;
}

@end
