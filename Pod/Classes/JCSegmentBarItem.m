//
//  JCSegmentBarItem.m
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCSegmentBarItem.h"
#import "JCSegmentBar.h"
#import "JCSegmentBarController.h"

@interface JCSegmentBarItem ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JCSegmentBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _title = @"";
        
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.text = @"";
}

#pragma mark - setter/getter

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    [self changeTitleLabelTextColor];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
    _badgeColor = badgeColor;
    
    [self changeTitleLabelTextColor];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    return _titleLabel;
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    
    self.titleLabel.font = selectedFont;
}

- (void)setUnSelectedFont:(UIFont *)unSelectedFont {
    _unSelectedFont = unSelectedFont;
    
    self.titleLabel.font = unSelectedFont;
}

#pragma mark - private

- (void)changeTitleLabelTextColor {
    NSInteger location = [self.title rangeOfString:@" "].location;
    
    if (location != NSNotFound) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, location)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.badgeColor range:NSMakeRange(location+1, self.title.length-(location+1))];
        self.titleLabel.attributedText = attributedString;
    }
    else {
        self.titleLabel.textColor = self.textColor;
    }
}

@end
