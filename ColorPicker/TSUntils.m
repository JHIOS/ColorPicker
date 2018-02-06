//
//  TSUntils.m
//  TSIDE
//
//  Created by TouchSprite on 2017/9/21.
//  Copyright © 2017年 TouchSpritewww.mdr. All rights reserved.
//

#import "TSUntils.h"

#import "NetworkUtils.h"

@interface TSUntils()

@end

@implementation TSUntils

SingletonM(TSUntils)

+ (void)callActionParams:(TSNetParam*)netParam
           resultctxCall:(void (^)(id response))successBlock{
    
    NSDictionary *ideInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"TSIDE"];
    if (!ideInfo) {
//        [self logInConsole:@"请先输入IP"];
        return;
    }
    
    NSString *urlString = ideInfo[@"deviceIP"];
    NSString *auth = ideInfo[@"auth"];
    
    
    netParam.auth = auth;
    
    NSString *action = netParam.action;
    
    NSString *requestUrl = [NSString stringWithFormat:@"http://%@/%@",urlString,action];
    
    
    if ([action isEqualToString:@"upload"]) {
        
        netParam.ContentType = @"touchsprite/uploadfile";
        netParam.reqMethod = @"POST";

    }
    if ([action isEqualToString:@"setLuaPath"]) {
        
        netParam.ContentType = @"application/json";
        netParam.reqMethod = @"POST";

    }
    
    if ([action isEqualToString:@"runLua"]) {
        
        netParam.reqMethod = @"GET";

    }
    if ([action isEqualToString:@"status"]) {
        
        netParam.reqMethod = @"GET";
    }
    if ([action containsString:@"snapshot"]) {
        
        netParam.reqMethod = @"GET";
        
    }
    
    
    NSString *reqMethod = netParam.reqMethod;
    NSString *data = netParam.data;
    NSDictionary *headParam = [netParam dicFromModelProperties];
    
    [NetworkUtils request:requestUrl method:reqMethod head:headParam data:data success:^(id response) {
//        NSString *string=[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        successBlock(response);
    }];
    
    
}

@end


#import <objc/runtime.h>
@implementation TSNetParam

+(instancetype)netParam{
    return [[self alloc] init];
}
- (NSDictionary *)dicFromModelProperties
{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    // class:获取哪个类的成员属性列表
    // count:成员属性总数
    // 拷贝属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        // 属性名
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if ([propertyName isEqualToString:@"data"]
            ||[propertyName isEqualToString:@"action"]
            ||[propertyName isEqualToString:@"reqMethod"]) {
            continue;
        }

        // 属性值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue == nil) {
            break;
        }
        
        if ([propertyName isEqualToString:@"ContentType"]) {
            propertyName = @"Content-Type";
        }
        // 设置KeyValues
        if (propertyValue) [propsDic setObject:propertyValue forKey:propertyName];
    }
    // 需手动释放 不受ARC约束
    free(properties);
    return propsDic;
}




@end






