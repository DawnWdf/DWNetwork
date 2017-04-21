//
//  NSObject+DWRequestTask.m
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/19.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "NSObject+DWRequestTask.h"
#import <objc/runtime.h>
#import "DWHTTPSessionManager.h"

#define k_path @"NSObject+DWRequestTask_path_key"
#define k_method @"NSObject+DWRequestTask_method_key"
#define k_attributes @"DWRequestTask_attributes_key"
#define k_sessionDataTask @"DWRequestTask_sessionDataTask_key"

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@interface NSObject()

@property (nonatomic, strong) id attributes;
@property(nonatomic,strong)NSURLSessionDataTask *sessionDataTask;

@end


@implementation NSObject (DWRequestTask)

@dynamic path,method;

- (instancetype)initWithAttributes:(id)attributes{
    self = [[NSObject alloc] init];
    if (self) {
        self.attributes = attributes;
    }
    return self;
}
- (void)excute:(void(^)(NSInteger statusCode, id responseObject))success failed:(void(^)(NSInteger statusCode, NSError *error))failed{
    [self cancel];
    //打印当前请求属性
    NSLog(@"%@ %ld  %@",self.path,self.method,self.attributes);
    DWHTTPSessionManager *manager = [DWHTTPSessionManager shareInstance];
    
    void(^sessionSuccess)(NSURLSessionDataTask * _Nonnull task,id _Nullable response) = ^(NSURLSessionDataTask * _Nonnull task,id _Nullable response){
        
    };
    
    void(^sessionFailed)(NSURLSessionDataTask * _Nonnull task , NSError * _Nullable error) = ^(NSURLSessionDataTask * _Nonnull task , NSError * _Nullable error){
        
    };
    
    self.sessionDataTask = [manager GET:self.path parameters:self.attributes progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:sessionSuccess failure:sessionFailed];
    
    
    [self.sessionDataTask resume];
}

- (void)cancel{
    [self.sessionDataTask cancel];
    self.sessionDataTask = nil;
}

#pragma mark - getter & setter

- (void)setSessionDataTask:(NSURLSessionDataTask *)sessionDataTask {
    objc_setAssociatedObject(self, k_sessionDataTask, sessionDataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLSessionDataTask *)sessionDataTask {

   return  objc_getAssociatedObject(self, k_sessionDataTask);
}

- (void)setAttributes:(id)attributes{
    objc_setAssociatedObject(self, k_attributes, attributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)attributes{
    return objc_getAssociatedObject(self, k_attributes);
}

- (void)setPath:(NSString *)path{
    objc_setAssociatedObject(self, k_path, path, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)path{
    return objc_getAssociatedObject(self, k_path);;
}

- (void)setMethod:(NSInteger)method{
    objc_setAssociatedObject(self, k_method, [NSNumber numberWithInteger:method], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)method{
    return [objc_getAssociatedObject(self, k_method) integerValue];
}
@end
