//
//  DWHTTPRequestSerializer.m
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/20.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "DWHTTPRequestSerializer.h"

static DWHTTPRequestSerializer *serializer = nil;

@implementation DWHTTPRequestSerializer

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serializer = [DWHTTPRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //and so on
        
    });
    return serializer;
}
@end
