//
//  Pay2ViewController.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/15.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "Pay2ViewController.h"

#import "payView.h"
#import "PayAdviceViewController.h"

@interface Pay2ViewController ()

@end

@implementation Pay2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *button = ({
        UIButton *but = [UIButton buttonWithType:(UIButtonTypeSystem)];
        but.frame = CGRectMake(100, 300, 100, 100);
        [but setTitle:@"pop上一页" forState:(UIControlStateNormal)];
        [but addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        but;
    });
    [self.view addSubview:button];
}

-(void)buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
