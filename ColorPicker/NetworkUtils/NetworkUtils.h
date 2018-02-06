//
//  NetworkUtils.h
//  MaService
//
//  Created by 蒋豪 on 2016/11/25.
//  Copyright © 2016年 蒋豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUtils : NSObject

+(void)request:(NSString *)url method:(NSString*)method data:(NSString*)data success:(void (^)(id response))success;

+(void)request:(NSString *)url method:(NSString*)method head:(NSDictionary*)head data:(NSString*)data success:(void (^)(id response))success errorCall:(void (^)(id error))errorBlock;

+(void)request:(NSString *)url method:(NSString*)method head:(NSDictionary*)head data:(NSString*)data success:(void (^)(id response))success;
@end
