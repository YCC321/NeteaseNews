//
//  News.m
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
#import <objc/runtime.h>


@implementation News


+ (instancetype)newsWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    NSArray *propertis = [self loadProperties];
    
    for (NSString *key in propertis) {
        // 判断 dict 是否存在 key
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKeyPath:key];
        }
    }
    //    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}
//获取对象属性数量

const char *kPropertiesKey = "kPropertiesKey";
+ (NSArray *)loadProperties {
    
    // 利用`关联`对象，给`类`添加属性，OC中的类，本身就是一个特殊对象
    /**
     获取关联对象
     1. 对象，属性关联到的对象
     2. key，属性的 key
     */
    NSArray *pList = objc_getAssociatedObject(self, kPropertiesKey);
    if (pList != nil) {
        return pList;
    }
    
    /**
     1. 类
     2. 属性计数指针
     */
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSLog(@"属性数量 %u", count);
    
    // 遍历数组
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; ++i) {
        // C语言中没有对象的概念，一般不需要使用 `*`
        objc_property_t pty = list[i];
        
        // 属性名称
        const char *cname = property_getName(pty);
        
        // 添加到数组
        [arrayM addObject:[NSString stringWithUTF8String:cname]];
    }
    NSLog(@"%@", arrayM);
    
    // 释放对象
    free(list);
    
    // 设置关联对象对象
    /**
     设置关联对象属性，运行时机制中，在OC开发的应用，关联对象使用的频率最高！
     
     1. 属性关联的对象
     2. key
     3. 值
     4. 引用关系
     */
    objc_setAssociatedObject(self, kPropertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, kPropertiesKey);
}

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
            [arrayM addObject:[self newsWithDict:obj]];
            
        }
        //直接回调
        finished(arrayM.copy);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    
    }];
    
    
    
}

@end