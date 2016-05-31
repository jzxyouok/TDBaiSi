//
//  TDWebViewController.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/30.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDWebViewController : UIViewController

/** 跳转地址 */
@property (nonatomic, strong) NSURL *url;

@end


// UIWebView:在当前应用打开
// UIWebView没有这些功能,必须手动去实现,进度条做不了.
// safari:跳转到safari应用,离开当前应用
// safari:自带很多功能,前进,后退,刷新,进度条,网址