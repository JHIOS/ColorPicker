//
//  ErmConnection.m
//  MaService
//
//  Created by 蒋豪 on 2016/11/26.
//  Copyright © 2016年 蒋豪. All rights reserved.
//

#import "ErmConnection.h"
@interface ErmConnection()<NSURLConnectionDataDelegate>


@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *receiveData;
@property (nonatomic, assign) int64_t exceptedBytes;
@property (nonatomic, assign) int64_t receiveBytes;
@property (nonatomic, assign) float progress;
@property (nonatomic, copy) void (^progressBlock)(float ,NSData *);



@end

@implementation ErmConnection
/**
 发送网络请求
 
 :returns: 返回NSData，optional
 */
-(NSData*)startSynchronous{

    NSURLResponse *response=[[NSURLResponse alloc]init];
    NSData *returnData=[NSURLConnection sendSynchronousRequest:self.urlRequest returningResponse:&response error:nil];
    return returnData;
    
}
/**
 发送异步网络请求
 */

-(void)startAsynchronous{
    self.connection=nil;
    // 判断是否有网络连接
    //        if !IJReachability.isConnectedToNetwork(){
    //            return
    //        }
    self.receiveData = [[NSMutableData alloc]initWithLength:0];
    self.receiveBytes = 0;
    self.exceptedBytes = 0;
    self.connection=[NSURLConnection connectionWithRequest:_urlRequest delegate:self];
    [self.connection start];
}
/**
 取消当前网络请求
 */

-(void)cancelCurrentRequest{
    _receiveData = nil;
    _exceptedBytes = 0;
    _receiveBytes = 0;
    _progress = 0;
    [_connection cancel];
}
/**
 请求出现错误
 
 :param: connection 网络连接
 :param: error      错误
 */
-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    if (_errorBlock!=nil) {
        
        if (error.code == -1004) {
            error = [NSError errorWithDomain:@"连接不到服务器,请检查网络" code:-1004 userInfo:nil];
        }else if (error.code == -1001){
            error = [NSError errorWithDomain:@"请求超时" code:-1001 userInfo:nil];
        }
        
        _errorBlock(error);
    }
    _receiveData = nil;
    _exceptedBytes = 0;
    _receiveBytes = 0;
    _progress = 0;

}



/**
 收到响应方法
 
 :param: connection 网络连接
 :param: response   响应对象
 */
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response{
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
    if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"http status code:%ld",(long)httpResponse.statusCode] code:10001 userInfo:nil];
        if (_errorBlock!=nil) {
            _errorBlock(error);
        }
        
        NSLog(@"httpResponse error");
    }
    if (_receiveData!=nil) {
        _receiveData.length=0;
    }
    _exceptedBytes=httpResponse.expectedContentLength;
}



/**
 收到数据调用（没收到一次数据调用一次）
 
 :param: connection 网络连接
 :param: data       本次得到数据
 */
-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data{
    [_receiveData appendData:data];
    int64_t len=data.length;
    _receiveBytes+=len;
    if (_exceptedBytes!=INT64_MAX-1) {
        _progress = (float)_receiveBytes/(float)_exceptedBytes;
        if (_progressBlock!=nil) {
            _progressBlock(_progress,data);
        }
    }
}


/**
 网络请求完成
 
 :param: connection 网络连接
 */
-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    
    if (_finishBlock!=nil) {
        _finishBlock(_receiveData);
    }
    _connection=nil;

    _receiveData = nil;
    _exceptedBytes = 0;
    _receiveBytes = 0;
    _progress = 0;
}

/**
 处理缓存问题
 */

-(NSCachedURLResponse *)connection:(NSURLConnection*)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse{
    return cachedResponse;
}


@end
