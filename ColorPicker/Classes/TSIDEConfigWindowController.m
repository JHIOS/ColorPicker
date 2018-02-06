//
//  TSIDEConfigWindowController.m
//  TSIDE
//
//  Created by TouchSprite on 2017/9/20.
//  Copyright © 2017年 TouchSpritewww.mdr. All rights reserved.
//

#import "TSIDEConfigWindowController.h"
#import "NetworkUtils.h"

@interface TSIDEConfigWindowController ()

@property (weak) IBOutlet NSTextField *ipTextFiled;
@property (weak) IBOutlet NSTextField *portTextFiled;

@property (weak) IBOutlet NSTextField *statusTextFiled;


@end

@implementation TSIDEConfigWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    NSDictionary *ideInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"TSIDE"];
    NSString *deviceIP = ideInfo[@"deviceIP"];

    if (deviceIP) {
        NSArray *deviceArr = [deviceIP componentsSeparatedByString:@":"];
        if (deviceArr.count == 2) {
            self.ipTextFiled.stringValue = deviceArr[0];
            self.portTextFiled.stringValue = deviceArr[1];
        }
    }
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)closeAction:(id)sender {
    [self close];
}

- (IBAction)submitAction:(NSButton *)sender {
    
    NSString *deviceIP = [NSString stringWithFormat:@"%@:%@",self.ipTextFiled.stringValue,self.portTextFiled.stringValue];
    NSString *urlString = [NSString stringWithFormat:@"http:%@/deviceid",deviceIP];

    self.statusTextFiled.hidden = NO;
    self.statusTextFiled.stringValue = @"正在获取设备号...";
    __weak typeof(self) weakSelf = self;
    
    [NetworkUtils request:urlString method:@"GET" data:nil success:^(id response) {
        
        weakSelf.statusTextFiled.stringValue = @"获取设备号成功";
        weakSelf.statusTextFiled.stringValue = @"正在连接触动服务器";

        NSString *deviceid = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding
                            ];
        NSString *authString = @"https://storeauth.touchsprite.net/api/caller";
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *timeInter = [NSString stringWithFormat:@"%f",interval];
        NSDictionary *params = @{
                                 @"action" : @"getAuth",
                                 @"devices" : @[deviceid],
                                 @"caller" : @"c63562edb9040f3a4d29f695c0fd31aa",
                                 @"time" : timeInter,
                                 @"valid" : @"2592000",
                                 @"callerInfo" : @"IDE build:1014",
                                 };
        NSError *jsonError;
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&jsonError];
        if (!jsonData) {
            NSLog(@"---------->json转字符串错误 %@",jsonError);
        }
        
        NSString *string=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [NetworkUtils request:authString method:@"POST" data:string success:^(id response) {
            weakSelf.statusTextFiled.stringValue = @"认证成功";
            @try {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
                
                if (![dic[@"status"] isEqualToNumber:@200]) {
                    weakSelf.statusTextFiled.stringValue = dic[@"message"];
                    return;
                }else{
                    weakSelf.statusTextFiled.stringValue = @"认证成功";
                    [dic setValue:deviceIP forKey:@"deviceIP"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"TSIDE"];

                }
            } @catch (NSException *exception) {
                weakSelf.statusTextFiled.stringValue = @"认证异常";
            }
   
        }];
        
        

    }];

}





@end
