//
//  NetworkTools.m
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+(instancetype)sharedNetworkTools{

    static NetworkTools *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        /**
         *  后续使用可以使用相对路径
         但是要注意,末尾以 ' / ' 结尾
         */
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        instance = [[self alloc] initWithBaseURL:url];
        
        //设置 添加响应解析的数据格式    添加@"text/html"格式的数据 进行反序列化,AFN值默认前面三种数据类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });

    return instance;
}
@end
