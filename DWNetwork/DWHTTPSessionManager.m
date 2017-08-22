//
//  DWHTTPSessionManager.m
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/19.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "DWHTTPSessionManager.h"
#import "DWHTTPRequestSerializer.h"

static DWHTTPSessionManager *sessionManager = nil;

@implementation DWHTTPSessionManager


+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //创建httpSessionManager
        DWHTTPSessionManager *manager = [DWHTTPSessionManager manager];
        
        //设置请求序列 可自定义头信息
        manager.requestSerializer = [DWHTTPRequestSerializer shareInstance];
        //设置响应序列 可单独成独立类型
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableSet *contents = [NSMutableSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript",@"text/plain",@"image/png", nil];
        responseSerializer.acceptableContentTypes = contents;
        manager.responseSerializer = responseSerializer;

        //设置安全策略 - 暂无
        [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        
        sessionManager = manager;

    });
    return sessionManager;
}

- (void)configHeaders:(NSDictionary *)headers {
    if (headers) {
        DWHTTPSessionManager *manager = [DWHTTPSessionManager shareInstance];
        /*
        id contentType = headers[@"Content-Type"];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableSet *contents = [NSMutableSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript",@"text/plain", nil];
        if (contentType && [contentType isKindOfClass:[NSArray class]]) {
            [contents addObjectsFromArray:contentType];
        }else if (contentType && [contentType isKindOfClass:[NSString class]]){
            [contents addObject:contentType];
        }else{
        }
        responseSerializer.acceptableContentTypes = contents;
        manager.responseSerializer = responseSerializer;
         */
        
        [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
}


#pragma mark - mark

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *certificate = nil;
    
    if (certificate == nil)
    {
        return nil;
    }
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = YES;
    if (certData) {
        securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    }
    return securityPolicy;
}

@end
