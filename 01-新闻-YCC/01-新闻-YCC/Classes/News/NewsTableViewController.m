//
//  NewsTableViewController.m
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "NewsTableViewController.h"
#import "News.h"
#import "NewsCell.h"
@interface NewsTableViewController ()
@property (nonatomic, strong) NSArray *newsList;

@end

@implementation NewsTableViewController

-(void)setNewsList:(NSArray *)newsList{
    _newsList = newsList;
    
    //刷新表格
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试加载新闻
    
    __weak typeof(self) weakSelf = self;
    [News loadNewsListWithURLString:@"T1348647853363/0-20.html" finished:^(NSArray *newsList){
        //设置数组数值
        weakSelf.newsList = newsList;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.news = self.newsList[indexPath.row];
    
    return cell;
}


@end
