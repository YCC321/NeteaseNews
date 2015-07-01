//
//  AppDelegate.m
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置缓存
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
                    // 这个'🔼'目录参数传 nil  会自动使用沙盒里面的目录 用作缓存目录
    [NSURLCache setSharedURLCache:cache];
    //设置网络指示器 - 后续的AFN 网络请求都会显示小菊花
    //
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    
        return YES;
}

@end
