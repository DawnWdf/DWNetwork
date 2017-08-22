//
//  ViewController.m
//  DWNetworkDemo
//
//  Created by Dawn Wang on 2017/4/10.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking/AFNetworking.h>

#import "MyTask.h"

#import "DWNetwork.h"

@interface ViewController ()
{
    NSString *lastModify;
}


@property (nonatomic, strong) NSObject *task;

@property (nonatomic, strong) MyTask *myTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.task = [[NSObject alloc]initWithAttributes:@""];
//    self.myTask  = [[DWRequestTask alloc] initWithAttributes:@{@"key":@"1c3d999f473ee",@"username":@"dwdemo",@"password":@"qwer1234",@"email":@"icy19882006@163.com"}];
//    [self.myTask excute:^(NSInteger statusCode, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failed:^(NSInteger statusCode, NSError *error) {
//        NSLog(@"%ld",statusCode);
//    }];
    
//    MyTask *task = [[MyTask alloc]initWithAttributes:@{@"key":@"1c3d999f473ee",@"username":@"dwdemo",@"password":@"qwer1234"}];
    
    
    UIButton *requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    requestButton.frame = CGRectMake(20, 100, 200, 100);
    [requestButton addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
    [requestButton setTitle:@"request" forState:UIControlStateNormal];
    [requestButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:requestButton];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request{
    MyTask *task = [[MyTask alloc]initWithAttributes:nil headers:@{}];
    
    [task excute:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSInteger statusCode, id responseObject, id header) {
        NSLog(@"%ld",statusCode);
//        NSLog(@"%@",responseObject);
    } failed:^(NSInteger statusCode, NSError *error,id header) {
        NSLog(@"%ld",statusCode);
    }];
}

- (void)downloadTask{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"File downloaded to: %@", filePath);

    }];
    [downloadTask resume];
}

- (void)uploadTask{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

- (void)uploadWithProgress{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
    }];
    [dataTask resume];
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
//    } error:nil];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSProgress *progress;
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//    }];
    
//    [uploadTask resume];
}

- (void)networkStatus{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
}

@end
