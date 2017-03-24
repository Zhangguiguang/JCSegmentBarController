//
//  JCSegmentBarItem.h
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCSegmentBarItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSDictionary *titleAttributes;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;

@end
