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
@property(nonatomic,strong) NSURLSessionDataTask *sessionDataTask;

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
        if (success) {
            NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
            success(statusCode, [self checkResponseValid:response]);
        }
    };
    
    void(^sessionFailed)(NSURLSessionDataTask * _Nonnull task , NSError * _Nullable error) = ^(NSURLSessionDataTask * _Nonnull task , NSError * _Nullable error){
        if (failed) {
            NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
            failed(statusCode, error);
        }
    };
    
    if (self.method == DWNetworkMethod_GET) {
        self.sessionDataTask = [manager GET:self.path parameters:self.attributes progress:nil success:sessionSuccess failure:sessionFailed];
    }else if (self.method == DWNetworkMethod_POST) {
        
        if (self.attributes && [self.attributes isKindOfClass:[NSData class]]) {
//            [self.sessionDataTask.reques setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
//                
//                NSString * string = [[NSString alloc] initWithData:parameters  encoding:NSISOLatin1StringEncoding];
//                return string;
//            }];
        }
        
        self.sessionDataTask = [manager POST:self.path parameters:self.attributes progress:nil success:sessionSuccess failure:sessionFailed];
    }else if (self.method == DWNetworkMethod_PUT){
        self.sessionDataTask = [manager PUT:self.path parameters:self.attributes success:sessionSuccess failure:sessionFailed];
    }else if (self.method == DWNetworkMethod_DELETE) {
        self.sessionDataTask = [manager DELETE:self.path parameters:self.attributes success:sessionSuccess failure:sessionFailed];
    }else if (self.method == DWNetworkMethod_PETCH) {
        self.sessionDataTask = [manager PATCH:self.path parameters:self.attributes success:sessionSuccess failure:sessionFailed];
    }
    
    
    
    [self.sessionDataTask resume];
}

- (void)cancel{
    [self.sessionDataTask cancel];
    self.sessionDataTask = nil;
}

#pragma mark - logic
- (NSDictionary *)checkResponseValid:(id)responseObject{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        return responseObject;
    }else if([responseObject isKindOfClass:[NSData class]]){
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            return result;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
    
    return nil;
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
