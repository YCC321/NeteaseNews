//
//  News.h
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
//新闻标题
@property (nonatomic, copy) NSString *title;
//新闻摘要
@property (nonatomic, copy) NSString *digest;
//配图地址
@property (nonatomic, copy) NSString *imgsrc;
//跟帖数量
@property (nonatomic, assign) int replyCount;
//多图数组(2张)
@property (nonatomic, strong) NSArray *imgextra;
//是否大图标记
@property (nonatomic, assign,getter=isBigImage ) BOOL imgType;

//加载指定 URL 的新闻数组
+(void)loadNewsListWithURLString:(NSString *)urlString finished:(void (^)(NSArray *newsList))finished;
@end
