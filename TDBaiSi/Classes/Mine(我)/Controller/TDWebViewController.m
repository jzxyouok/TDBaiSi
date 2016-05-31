
//
//  TDWebViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/30.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDWebViewController.h"
#import <WebKit/WebKit.h> // WebKit框架

@interface TDWebViewController ()

//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation TDWebViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    //添加View显示在最上面
    [self.view insertSubview:webView atIndex:0];
//    [webView bringSubviewToFront:self.view]; //错误
    
    //2.加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    
    //3.KVO: 让self对象监听webView的estimatedProgress
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO监听
// 只要监听的属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //设置进度条
    _progressView.progress = _webView.estimatedProgress;
    _progressView.hidden = _progressView.progress >= 1;
}

// KVO一定要移除观察者
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
