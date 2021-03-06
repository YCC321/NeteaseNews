//
//  News.m
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
#import "NSObject+Extension.h"


@implementation News


//看到数组的具体内容,重写description
- (NSString *)description{
    //pods JSON  把自定义对象转成字典
    NSArray *propertis = [self.class loadProperties];

    
    NSDictionary *dict = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, dict];
}

//异步方法,不能直接返回,块代码回调
+ (void)loadNewsListWithURLString:(NSString *)urlString finished:(void (^)(NSArray *))finished{
    
    NSAssert(finished != nil, @"必须完成回调");
    //发送网络请求
    [[NetworkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        /**
         *  url的不同,第一层字典的 key不同
         利用 keyEnumerator.nextObject 方法拿到第一个key
         keyEnumerator.nextObject 该方法主要用来遍历字典
         */
        NSLog(@"%@", responseObject.keyEnumerator.nextObject);
        //根据 key 拿到第一个数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
        
        //字典转模型 创建数组
        //Capacity 容量  根据容量的多少,会一次性分配该容量个数的空间
        //当再添加新的元素的时候,会再多加开辟存储新元素的空间,系统不会崩溃. 会自动递增
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        //字典转模型
        for (NSDictionary *obj in array) {
            [arrayM addObject:[self objectWithDict:obj]];
            
        }
        //直接回调
        finished(arrayM.copy);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    
    }];
    
    
    
}

@end