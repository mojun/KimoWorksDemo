//
//  WebViewController.m
//  JavaScriptBridgeDemo
//
//  Created by mojun on 15/12/31.
//  Copyright © 2015年 kimoworks. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) WebViewJavascriptBridge *bridge;
@property (strong, nonatomic) IBOutlet UIWebView *web;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.web webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"获取到js 的消息: %@", data);
    }];
    
    
    [self.bridge registerHandler:@"CloseWindow" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"关闭窗口");
        NSLog(@"并且获取js传过来的数据：%@", data);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.bridge registerHandler:@"OpenSafari" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *url = [data objectForKey:@"url"];
        NSLog(@"url: %@", url);
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
    }];
    
//    [self.bridge callHandler:@"GetUserInfoDone"];
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.web loadHTMLString:appHtml baseURL:baseURL];
}
- (IBAction)makeJsDo:(id)sender {
    [self.bridge callHandler:@"GetUserInfoDone" data:@{@"somedata": @"yo!"} responseCallback:^(id responseData) {
        NSLog(@"在OC主动调用js，获取到来自js返回的数据: %@", responseData);
    }];
    
//    [self.bridge send:@"GetUserInfoDone" responseCallback:^(id responseData) {
//        
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
