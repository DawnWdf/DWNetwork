//
//  NSObject+DWRequestTask.h
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/19.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DWRequestTaskProtocol.h"

typedef NS_ENUM(NSInteger , DWNetworkMethod){
    DWNetworkMethod_GET,
    DWNetworkMethod_POST,
    DWNetworkMethod_PUT,
    DWNetworkMethod_DELETE,
    DWNetworkMethod_PETCH
} ;

@interface NSObject (DWRequestTask) <DWRequestTaskProtocol>

@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) NSInteger method;


@end
