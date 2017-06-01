//
//  MapStickersViewController.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/16.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "MapStickersViewController.h"

#import "MapStickersView.h"

@interface MapStickersViewController ()

@property(nonatomic,strong) MapStickersView *myView;

@end

@implementation MapStickersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"贴纸";    
    
    [self up_view];
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"下载图片到相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(upLoad)];
    self.navigationItem.rightBarButtonItem = myButton;
}

-(void)up_view
{
    _myView = [[MapStickersView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_myView];
}

-(void)upLoad
{
    [_myView upImageToPhotoAlbum];
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
