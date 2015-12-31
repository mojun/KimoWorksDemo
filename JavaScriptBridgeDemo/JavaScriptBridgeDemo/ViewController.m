//
//  ViewController.m
//  JavaScriptBridgeDemo
//
//  Created by mojun on 15/12/31.
//  Copyright © 2015年 kimoworks. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)presentVC:(id)sender {
    WebViewController *webVC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:webVC];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
