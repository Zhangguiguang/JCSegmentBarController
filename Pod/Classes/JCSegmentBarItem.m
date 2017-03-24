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
        _image = image;
        
        _titleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]};
    }
    
    return self;
}

#pragma mark - setter/getter

- (void)setTitleAttributes:(NSDictionary *)titleAttributes {
    NSMutableDictionary *tempAttributes = [[NSMutableDictionary alloc] initWithDictionary:titleAttributes];
    
    if (_titleAttributes) {
        [tempAttributes addEntriesFromDictionary:_titleAttributes];
    }
    
    _titleAttributes = tempAttributes;
}

@end
