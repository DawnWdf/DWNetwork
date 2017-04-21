//
//  DWHTTPRequestSerializer.h
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/20.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface DWHTTPRequestSerializer : AFHTTPRequestSerializer

+ (instancetype)shareInstance;

@end
