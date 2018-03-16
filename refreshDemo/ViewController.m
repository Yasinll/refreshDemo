//
//  ViewController.m
//  refreshDemo
//
//  Created by PatrickY on 2018/3/16.
//  Copyright © 2018年 PatrickY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray                             *datesM;

@end

@implementation ViewController {
    UIRefreshControl                                                    *_demoRefreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datesM = [NSMutableArray array];
    NSDate *date = [[NSDate alloc] init];
    [_datesM addObject:date];
    
    _demoRefreshControl = [[UIRefreshControl alloc] init];
    _demoRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    [_demoRefreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    //添加到refreshControl
    self.refreshControl = _demoRefreshControl;
}

- (void)refreshTableView {
    
    if (_demoRefreshControl.refreshing) {
        _demoRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中/..."];
        NSDate *date = [[NSDate alloc] init];
        
        [_datesM addObject:date];
        
        [_demoRefreshControl endRefreshing];
        _demoRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        
        [self.tableView reloadData];
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _datesM.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    cell.textLabel.text = [dateFormat stringFromDate:_datesM[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
