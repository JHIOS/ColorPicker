//
//  ErmConnection.h
//  MaService
//
//  Created by 蒋豪 on 2016/11/26.
//  Copyright © 2016年 蒋豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErmConnection : NSObject

@property (nonatomic, strong) NSURLRequest *urlRequest;
@property (nonatomic, copy) void (^finishBlock)(NSData *);
@property (nonatomic, copy) void (^errorBlock)(NSError *);

-(NSData*)startSynchronous;
-(void)startAsynchronous;
@end
