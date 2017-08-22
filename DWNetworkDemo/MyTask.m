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
//        self.path = @"http://apicloud.mob.com/user/login";
        self.path = @"https://mobile.gome.com.cn/mobile/product/printCatalog.jsp";
        self.method = DWNetworkMethod_GET;
        
    }
    return self;
}
- (instancetype)initWithAttributes:(id)attributes headers:(NSDictionary *)headers {
    self = [super initWithAttributes:attributes headers:headers];
    if (self) {
        self.path = @"http://ac-g3rossf7.clouddn.com/xc8hxXBbXexA8LpZEHbPQVB.jpg";
        self.method = DWNetworkMethod_GET;
        
    }
    return self;
}


@end
