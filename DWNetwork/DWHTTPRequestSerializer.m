//
//  DWHTTPRequestSerializer.m
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/20.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "DWHTTPRequestSerializer.h"

static DWHTTPRequestSerializer *serializer = nil;

@interface DWHTTPRequestSerializer()

@end

@implementation DWHTTPRequestSerializer

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
        
        serializer = [DWHTTPRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //and so on
        
        serializer.stringEncoding = NSUTF8StringEncoding;
        
        [serializer setLanguages];
        [serializer setUserAgent];
        
        
    });
    return serializer;
}

- (void)setLanguages{
    
    NSMutableArray *acceptLanguagesComponents = [NSMutableArray array];
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        float q = 1.0f - (idx * 0.1f);
        [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1f",obj,q]];
        *stop = q <= 0.5f;
    }];
    [self setValue:[acceptLanguagesComponents componentsJoinedByString:@","] forHTTPHeaderField:@"Accept-Language"];
}

- (void)setUserAgent{
   NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    [self setValue:userAgent forHTTPHeaderField:@"User-Agent"];

}
@end
