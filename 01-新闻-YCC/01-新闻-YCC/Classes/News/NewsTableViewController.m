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
    
    //设置预估行高
    self.tableView.estimatedRowHeight = 80;
    
    //设置行高(要求: 1. cell要有向下的约束,能够撑开整个Cell 2. 所有的下方向约束能够有负值)
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
    
    News *n = self.newsList[indexPath.row];
    NSString *ID = [NewsCell cellIdentifier:n];
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    
    cell.news = n;
    
    return cell;
}


@end
