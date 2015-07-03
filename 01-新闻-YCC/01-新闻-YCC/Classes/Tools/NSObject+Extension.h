//
//  NSObject+Extension.h
//  01-新闻-YCC
//
//  Created by sunny on 15/7/3.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

//字典转模型

+ (instancetype)objectWithDict:(NSDictionary *)dict;

//加载类的属性数组
+ (NSArray *)loadProperties;
@end
