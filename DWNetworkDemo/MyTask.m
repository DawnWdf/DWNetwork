//
//  MyTask.m
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/19.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "MyTask.h"

@implementation MyTask
- (instancetype)initWithAttributes:(id)attributes{
    self = [super initWithAttributes:attributes];
    if (self) {
        self.path = @"http://apicloud.mob.com/user/login";
        self.method = DWNetworkMethod_GET;
        
    }
    return self;
}

@end
