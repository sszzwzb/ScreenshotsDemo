//
//  PayViewController.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/12.
//  Copyright © 2017年 kaiyi. All rights reserved.
//


/**
 
 用通知写的代码，在首页一次调用，之后的页面都可以直接用，不用添加代码。不知道这么写好不好，如果大家有什么更好的方法希望可以一起学习，添加我的个人qq：896507132。备注iOS开发，截屏。
 
 1、支付宝反馈里添加了，UITextView输入字数控制，对汉字输入有控制。
 2、高德地图贴纸里面添加图片的 移动，旋转，缩放。 其中对，移动和缩放有很好的范围控制。
 添加UIView上的图片清晰截取功能，到相册。
 3、高德地图下载长图片到相册。截取UITabelView 或 UIScrollView 的图片（手机看不到的也能）。清晰的
 
 */


#import "PayViewController.h"

#import "Pay2ViewController.h"


#import "payView.h"
#import "PayAdviceViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self up_userDidTakeScreenshot];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UILabel *label = ({
        UILabel *lab = [[UILabel alloc]init];
        lab.frame = self.view.frame;
        lab.text = @"假装是支付宝的任意界面";
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab;
    });
    [self.view addSubview:label];
    
    UIButton *button = ({
        UIButton *but = [UIButton buttonWithType:(UIButtonTypeSystem)];
        but.frame = CGRectMake(100, 300, 100, 100);
        [but setTitle:@"push到下一页" forState:(UIControlStateNormal)];
        [but addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        but;
    });
    [self.view addSubview:button];
    
}

-(void)buttonAction
{
    Pay2ViewController *VC = [[Pay2ViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}


/**
 *
 *  写在UITabBarController层里，他下面的页面就都可以用了。
 *
 */
-(void)up_userDidTakeScreenshot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payViewAction) name:@"presentPayAdviceViewController" object:nil];
    
    //  先设置隐藏在右边的侧栏
    payView *PV = [[payView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:PV];
}

-(void)payViewAction
{
    PayAdviceViewController *PVC = [[PayAdviceViewController alloc]init];
    [self.navigationController pushViewController:PVC animated:YES];
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
