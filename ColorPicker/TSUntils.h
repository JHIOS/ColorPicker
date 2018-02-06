//
//  TSUntils.h
//  TSIDE
//
//  Created by TouchSprite on 2017/9/21.
//  Copyright © 2017年 TouchSpritewww.mdr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#define SingletonH(name) + (instancetype)shared##name;

// .m文件
#define SingletonM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

@interface IDEConsoleTextView : NSObject

@property (nonatomic , assign) int logMode;
- (void)insertText:(id)insertString;
- (void)insertNewline:(nullable id)sender;

- (void)viewDidUnhide;
- (void)viewDidHide;
- (void)awakeFromNib;
@end


@interface TSNetParam : NSObject

@property(nonatomic,copy,nullable) NSString *auth;
@property(nonatomic,copy,nullable) NSString *action;
@property(nonatomic,copy,nullable) NSString *data;
@property(nonatomic,copy,nullable) NSString *ContentType;
@property(nonatomic,copy,nonnull) NSString *reqMethod;

@property(nonatomic,copy,nullable) NSString *filename;
@property(nonatomic,copy,nullable) NSString *path;
@property(nonatomic,copy,nullable) NSString *root;


+(instancetype)netParam;
- (NSDictionary *)dicFromModelProperties;


@end



@interface TSUntils : NSObject


+ (void)callActionParams:(TSNetParam*)netParam
           resultctxCall:(void (^)(id response))successBlock;

@end
