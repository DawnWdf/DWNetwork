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
- (instancetype _Nonnull )initWithAttributes:(id _Nullable )attributes;
- (instancetype _Nonnull)initWithAttributes:(id _Nullable)attributes headers:(NSDictionary *_Nullable)headers;

- (void)excute:(void(^_Nullable)(NSInteger statusCode, id _Nullable responseObject))success failed:(void(^_Nullable)(NSInteger statusCode, NSError * _Nullable error))failed;
- (void)excute:(void(^_Nullable)(NSProgress * _Nonnull downloadProgress))progress success:(void(^_Nullable)(NSInteger statusCode, id _Nullable responseObject,id _Nullable headers))success failed:(void(^_Nullable)(NSInteger statusCode, NSError * _Nullable error,id _Nullable headers))failed;

@optional
- (void)printURL;
- (void)printRequestAttributes;
- (void)printResponseObject;
@end
