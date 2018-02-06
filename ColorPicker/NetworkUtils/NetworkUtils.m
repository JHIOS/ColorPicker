//
//  NetworkUtils.m
//  MaService
//
//  Created by 蒋豪 on 2016/11/25.
//  Copyright © 2016年 蒋豪. All rights reserved.
//

#import "NetworkUtils.h"
#import "ErmConnection.h"
#import "TSUntils.h"
@interface NetworkUtils()

@end

@implementation NetworkUtils

static NSTimeInterval timeoutInterval = 5;

+(void)request:(NSString *)url method:(NSString*)method head:(NSDictionary*)head data:(NSString*)data success:(void (^)(id))success errorCall:(void (^)(id))errorBlock{
    
    // 实例化一个url请求,并设置缓存策略为:忽略本地缓存数据
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeoutInterval];
    //请求超时,timeoutInterval重新设置为15s
    timeoutInterval=5;
    
    //请求体 客户端发给服务器的具体数据，比如文件数据
    NSData *bodyData=[data dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody=bodyData;
    
    //请求头 包含了对客户端的环境描述、客户端请求信息等,Accept-Encoding: gzip 客户端支持的数据压缩格式
    NSMutableDictionary *headDic = [NSMutableDictionary dictionaryWithDictionary:@{@"gzip":@"Accept-Encoding",
                                                                                   @"application/x-www-form-urlencoded":@"Content-Type"}];
    if (head) {
        [headDic setDictionary:head];
    }
    
    [urlRequest setAllHTTPHeaderFields:headDic];
    //请求方式
    [urlRequest setHTTPMethod:method];
    
    ErmConnection *connection=[ErmConnection new];
    connection.urlRequest=urlRequest;
    //发送异步网络请求
    [connection startAsynchronous];
    
    connection.finishBlock=^(NSData *data){
        if (data==nil) {
            NSLog(@"网络连接失败，请检查服务器配置!");
//            [TSUntils logInConsole:@"网络连接失败，请检查服务器配置!"];
            return;
        }
        success(data);
        return;
    };
    
    connection.errorBlock = ^(NSError *error){
        
        if(errorBlock){
            errorBlock(error);
        }else{
//            [TSUntils logInConsole:[NSString stringWithFormat:@"网络连接失败:%@",error]];
        }
        return ;
    };
    
    

}

+(void)request:(NSString *)url method:(NSString*)method data:(NSString*)data success:(void (^)(id response))success {

    [self request:url method:method head:nil data:data success:success errorCall:nil];

}

+(void)request:(NSString *)url method:(NSString*)method head:(NSDictionary*)head data:(NSString*)data success:(void (^)(id response))success{
    [self request:url method:method head:head data:data success:success errorCall:nil];
}


@end
