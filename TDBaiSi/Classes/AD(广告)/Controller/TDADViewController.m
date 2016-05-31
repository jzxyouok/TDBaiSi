//
//  TDADViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/27.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDADViewController.h"
#import "TDTabBarController.h"
#import "TDADItem.h"
#import "TDHttpTool.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define TDCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface TDADViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
/** 展示广告图片 */
@property (nonatomic, weak) UIImageView *adImageView;
/** 数据模型 */
@property (nonatomic ,strong) TDADItem *item;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation TDADViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 启动图片（屏幕适配）
    [self setUpLaunchImage];
    
    // 广告数据
    [self loadAdData];

    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

#pragma mark -------------------
#pragma mark 监听方法
// 倒计时显示
- (void)timeChange {
    
    static int i = 3;
    if (i <= 0) { // 计时完成
        [self jumpClick:nil];
    }
    
    //设置按钮显示
    NSString *str = [NSString stringWithFormat:@"跳过 (%d)",i];
    [self.jumpBtn setTitle:str forState:UIControlStateNormal];
    
    i--;
}

#pragma mark - 跳过按钮
- (IBAction)jumpClick:(id)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[TDTabBarController alloc] init];
    
    //销毁定时器
    [_timer invalidate];
}

#pragma mark - 点击广告图片
- (void)tap {
    //跳转到广告界面
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:_item.ori_curl]]) {
        [app openURL:[NSURL URLWithString:_item.ori_curl]];
    }
    
}

#pragma mark -------------------
#pragma mark 搭建界面
#pragma mark - 加载广告数据
- (void)loadAdData {
    // 请求数据 -> 查看接口文档 -> 测试接口有没有问题 -> 解析数据(w_picurl,ori_curl:广告界面跳转地址,w,h) arr = dict[@"ad"]
    
    //1.创建请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = TDCode2;

    //2.发送请求
    [TDHttpTool get:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters success:^(id responseObject) {
    // 解析数据 -> 写成plist文件 -> 字典转模型 -> 模型数据展示界面
//        NSLog(@"%@", responseObject);
        
        //1.获取广告数据字典
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        
        //2.字典转模型
        self.item = [TDADItem mj_objectWithKeyValues:adDict];
        
        //防止除以0
        if (_item.w <= 0) return;
        
        //3.展示界面
        CGFloat W = ScreenW;
        CGFloat H = ScreenW / _item.w *_item.h;
        self.adImageView.frame = CGRectMake(0, 0, W, H);
        //加载广告图片
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    } failure:^(NSError *error) {
        //请求失败
        NSLog(@"%@",error);
    }];
    
}

/*
 占位视图实现:当一个界面,层次结构已经清晰,但是中间某一层位置,或者尺寸不确定,可以采用占位视图
 */
#pragma mark - 加载启动图片
- (void)setUpLaunchImage {
    //根据屏幕大小
    UIImage *image = nil;
    if (iphone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) {
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iphone4) {
        image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    self.launchImageView.image = image;
}

#pragma mark -------------------
#pragma mark 懒加载
// 广告图片
- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        _adImageView = imageView;
        [self.adView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
    }
    
    return _adImageView;
}

@end
