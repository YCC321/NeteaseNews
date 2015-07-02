//
//  NewsCell.h
//  01-新闻-YCC
//
//  Created by sunny on 15/7/2.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;

@interface NewsCell : UITableViewCell
@property(nonatomic,strong) News *news;

//可重用标示符
+ (NSString *)cellIdentifier:(News *)news;
@end
