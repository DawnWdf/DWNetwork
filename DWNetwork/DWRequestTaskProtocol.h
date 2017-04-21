//
//  DWRequestTaskProtocol.h
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/18.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DWRequestTaskProtocol <NSObject>

@required
- (instancetype)initWithAttributes:(id)attributes;
- (void)excute:(void(^)(NSInteger statusCode, id responseObject))success failed:(void(^)(NSInteger statusCode, NSError *error))failed;

@optional
- (void)printURL;
- (void)printRequestAttributes;
- (void)printResponseObject;
@end
