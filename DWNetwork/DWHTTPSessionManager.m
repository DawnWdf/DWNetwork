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
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript",@"text/plain", nil];
        manager.responseSerializer = responseSerializer;
        
        //设置安全策略 - 暂无
        [manager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        
        sessionManager = manager;

    });
    return sessionManager;
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
