//
//  NetworkTools.h
//  01-新闻-YCC
//
//  Created by sunny on 15/7/1.
//  Copyright (c) 2015年 sunny. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkTools : AFHTTPSessionManager
/**
 *  全局访问入口
 */
+(instancetype)sharedNetworkTools;
@end
