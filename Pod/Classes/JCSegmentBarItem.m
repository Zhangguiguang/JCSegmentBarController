//
//  JCSegmentBarItem.m
//  JCSegmentBarController
//
//  Created by 李京城 on 15/5/20.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCSegmentBarItem.h"

@implementation JCSegmentBarItem

- (instancetype)initWithTitle:(NSString *)title {
    return [self initWithTitle:title image:nil];
}

- (instancetype)initWithImage:(UIImage *)image {
    return [self initWithTitle:@"" image:image];
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image {
    if (self = [super init]) {
        _title = title;
        _titleColor = [UIColor colorWithRed:48/255.0f green:51/255.0f blue:59/255.0f alpha:1];
        _image = image;
    }
    
    return self;
}

@end
