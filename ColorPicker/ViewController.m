//
//  ViewController.m
//  ColorPicker
//
//  Created by 蒋豪 on 2018/2/4.
//  Copyright © 2018年 mdr. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "TSIDEConfigWindowController.h"
#import "TSUntils.h"

@interface ViewController()<WebFrameLoadDelegate>

@property (weak) IBOutlet WebView *mainWebView;
@property (nonatomic ,strong) WebViewJavascriptBridge* bridge;
@property (nonatomic, strong) TSIDEConfigWindowController *configurationWindowController;
@property (weak) IBOutlet NSTextFieldCell *runerror;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.mainWebView];


    
//    self.mainWebView.frameLoadDelegate = self;

    NSURL * url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"picker" ofType:@"html" inDirectory:@"web"]];
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [[self.mainWebView mainFrame] loadRequest:request];
    [self initMenu];
    // Do any additional setup after loading the view.
}

-(void)initMenu{
    NSMenu *appMenu = [NSApp mainMenu];
    
    NSMenuItem *pluginsMenuItem = [appMenu itemWithTitle:@"设置"];

    NSMenuItem *linkMenuItem = [[NSMenuItem alloc] initWithTitle:@"连接设备" action:@selector(linkAction) keyEquivalent:@""];
    NSMenuItem *jietuMenuItem = [[NSMenuItem alloc] initWithTitle:@"截图" action:@selector(jietu) keyEquivalent:@""];

    
    [pluginsMenuItem.submenu addItem:linkMenuItem];
    [pluginsMenuItem.submenu addItem:jietuMenuItem];
}

-(void)jietu{
    
    TSNetParam *param  = [TSNetParam netParam];
    param.action = @"snapshot?ext=jpg&compress=1&orient=0";
    
    [TSUntils callActionParams:param resultctxCall:^(id response) {
        
        NSData *imgData = (NSData*)response;
        NSString *base64String = [imgData base64EncodedStringWithOptions:0];
        
        [self.bridge callHandler:@"imgData" data:base64String responseCallback:^(id responseData) {
//            NSLog(@"ObjC received response: %@", responseData);
        }];
    }];
    
}

- (void)linkAction{
    
    self.configurationWindowController = [[TSIDEConfigWindowController alloc] initWithWindowNibName:NSStringFromClass(TSIDEConfigWindowController.class)];
    //    self.configurationWindowController.delegate = self;
    [self.configurationWindowController.window makeKeyWindow];
}





- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
