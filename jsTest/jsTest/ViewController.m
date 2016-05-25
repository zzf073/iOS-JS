//
//  ViewController.m
//  jsTest
//
//  Created by fengX on 16/5/25.
//  Copyright © 2016年 zzf073. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(200, 90, 40, 40)];
    bt.backgroundColor = [UIColor redColor];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(refreshXX) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshXX
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.mainDocumentURL.relativePath);
    
    
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/name"])
    {
        //[self.webView stringByEvaluatingJavaScriptFromString:@"alert('Trigger the JS!');"];
        NSString *info = [[UIDevice currentDevice] name];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"name\",\"%@\")",info];
        NSString *jx = [self.webView stringByEvaluatingJavaScriptFromString:js];
        return false;
    }
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/systemVersion"])
    {
        NSString *info = [[UIDevice currentDevice] systemVersion];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"systemVersion\",\"%@\")",info];
        NSString *jx = [self.webView stringByEvaluatingJavaScriptFromString:js];
        return false;
    }
    return true;
}

@end
