//
//  DWHTTPSessionManager.h
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/19.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface DWHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

@end
