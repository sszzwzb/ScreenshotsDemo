//
//  MapLongImgViewController.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/18.
//  Copyright © 2017年 kaiyi. All rights reserved.
//


/**
 
 用通知写的代码，在首页一次调用，之后的页面都可以直接用，不用添加代码。不知道这么写好不好，如果大家有什么更好的方法希望可以一起学习，添加我的个人qq：896507132。备注iOS开发，截屏。
 
 1、支付宝反馈里添加了，UITextView输入字数控制，对汉字输入有控制。
 2、高德地图贴纸里面添加图片的 移动，旋转，缩放。 其中对，移动和缩放有很好的范围控制。
 添加UIView上的图片清晰截取功能，到相册。
 3、高德地图下载长图片到相册。截取UITabelView 或 UIScrollView 的图片（手机看不到的也能）。清晰的
 
 */


#import "MapLongImgViewController.h"

#import "MapLongImgHeadView.h"

static NSString *HeaderIdentifier = @"header";

@interface MapLongImgViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) MapLongImgHeadView *headView;
@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,assign) NSInteger cellTag;  //  一般应该写NSarray的，懒得写了

@end

@implementation MapLongImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"下载图片到相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(upLoad)];
    self.navigationItem.rightBarButtonItem = myButton;

    _cellTag = -1;
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [MapLongImgHeadView headViewHeight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_cellTag == section) {
        return 0;
    }else
        return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier: HeaderIdentifier];
    if (_headView == nil) {
        _headView = [[MapLongImgHeadView alloc] initWithReuseIdentifier:HeaderIdentifier];
    }
    _headView.headViewBut.tag = 100 + section;
    [_headView.headViewBut addTarget:self action:@selector(headViewButHidden:) forControlEvents:(UIControlEventTouchUpInside)];
    return _headView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    cell.textLabel.text = [NSString stringWithFormat:@"我是cell %ld %ld",indexPath.section,indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ///  取消按键效果  按中后会返回成没有安过的效果
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"我点击了  %ld   %ld",(long)indexPath.section,(long)indexPath.row);
    
}

-(void)headViewButHidden:(UIButton *)button
{
    NSInteger section = button.tag - 100;
    
    if (_cellTag == section) {
        _cellTag = -1;
    } else {
        _cellTag = section;
    }
    [_tableView reloadData];
    
    NSLog(@"我点击了head  %ld",section);
    
}


-(void)upLoad
{
    NSLog(@"我点击了保存图片");
    
    NSInteger cellTag = _cellTag;  //  全展开
    _cellTag = -1;
    [_tableView reloadData];
    
    [self saveLongImage:_tableView];
    
    _cellTag = cellTag;   //  还原展开
    [_tableView reloadData];
}

// 长截图 类型可以是 tableView或者scrollView 等可以滚动的视图 根据需要自己改
- (void)saveLongImage:(UITableView *)table {
    
    UIImage* image = nil;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，调整清晰度。
    UIGraphicsBeginImageContextWithOptions(table.contentSize, YES, [UIScreen mainScreen].scale);
    CGPoint savedContentOffset = table.contentOffset;
    CGRect savedFrame = table.frame;
    table.contentOffset = CGPointZero;
    table.frame = CGRectMake(0, 0, table.contentSize.width, table.contentSize.height);
    [table.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    table.contentOffset = savedContentOffset;
    table.frame = savedFrame;
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        //保存图片到相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}

// 保存后回调方法

- (void)image: (UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功，可到相册查看" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil];
    [alert show];
    
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
