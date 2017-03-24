//
//  JCSegmentBarItemCustomView.m
//  JCSegmentBarController
//
//  Created by 李京城 on 2017/3/16.
//  Copyright © 2017年 lijingcheng. All rights reserved.
//

#import "JCSegmentBarItemCustomView.h"
#import "JCSegmentBarItem.h"

@interface JCSegmentBarItemCustomView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation JCSegmentBarItemCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.iconImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.iconImageView.frame = CGRectMake((self.bounds.size.width - 25)/2, 25, 25, 19);
    self.titleLabel.frame = CGRectMake(0, 49, self.bounds.size.width, 21);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.text = @"";
    self.iconImageView.image = nil;
}

#pragma mark - setter/getter

- (void)setSegmentBarItem:(JCSegmentBarItem *)segmentBarItem {
    _segmentBarItem = segmentBarItem;
    
    self.titleLabel.text = segmentBarItem.title;
    self.titleLabel.textColor = segmentBarItem.titleColor;
    
    self.iconImageView.image = segmentBarItem.image;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    
    return _iconImageView;
}

@end
