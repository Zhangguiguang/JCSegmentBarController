//
//  JCTableViewController.m
//  JCSegmentBarController
//
//  Created by 李京城 on 2016/12/17.
//  Copyright © 2016年 lijingcheng. All rights reserved.
//

#import "JCTableViewController.h"
#import "JCSegmentBarController.h"

@implementation JCTableViewController

static NSString * const reuseIdentifier = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark - UITableViewDelegate | UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %ld", self.title, (long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"selectedIndex: %ld, badgeValue: %@, segmentBarItem.title: %@ selectedViewController.title: %@", (long)self.segmentBarController.selectedIndex, self.badgeValue, self.segmentBarItem.title, self.segmentBarController.selectedViewController.title);
}

@end

