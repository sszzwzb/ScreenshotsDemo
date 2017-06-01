//
//  ViewController.m
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


#import "ViewController.h"

#import "PayViewController.h"

#import "MapViewController.h"

#import "MapLongImgViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"截屏demo";
    
    [self up_tableView];

}

-(void)up_tableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"仿支付宝截图功能";
            break;
            
        case 1:
            cell.textLabel.text = @"仿高德地图截图功能";
            break;
            
        case 2:
            cell.textLabel.text = @"仿高德地图截图功能，展开全屏保存图片";
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[PayViewController alloc]init] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[[MapViewController alloc]init] animated:YES];
    } else {
        [self.navigationController pushViewController:[[MapLongImgViewController alloc]init] animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
