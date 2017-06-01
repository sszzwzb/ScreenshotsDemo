//
//  MapStickersView.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/16.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "MapStickersView.h"

#import "MapImageViewMovingPictures.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

#define view_height     [[UIScreen mainScreen] bounds].size.height
#define view_width      [[UIScreen mainScreen] bounds].size.width    //  屏幕的宽高

#define rgba(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define color_gray                              rgba(0,0,0,0.5)


#define iOS9 ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_9_x_Max) && (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0))?(YES):(NO)

#define iOS10 ((NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_x_Max)?(YES):(NO))

static const NSArray *mapFilImgArr;
static const NSArray *mapFilTitleArr;

@interface MapStickersView () <UIGestureRecognizerDelegate>
{
    CGFloat _viewImgFramWidth;
    CGFloat _viewImgFramHeight;
}

@property(nonatomic,strong) UIImageView *viewImg;

@property(nonatomic,strong) MapImageViewMovingPictures *MovingPictures;

@property(nonatomic,strong) UIScrollView *StickersView;

@end


@implementation MapStickersView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        mapFilImgArr = @[[UIImage imageNamed:@"mapFilImg"],
                         [UIImage imageNamed:@"mapFilImg2"],
                         [UIImage imageNamed:@"mapFilImg"],
                         [UIImage imageNamed:@"mapFilImg2"],
                         [UIImage imageNamed:@"mapFilImg"],
                         [UIImage imageNamed:@"mapFilImg2"]];
        
        mapFilTitleArr = @[@"一路轻松畅通如梦中",
                           @"不见不散，迟到你买单",
                           @"一路轻松畅通如梦中",
                           @"不见不散，迟到你买单",
                           @"一路轻松畅通如梦中",
                           @"不见不散，迟到你买单"];
        
        
        [self up_view];
        
        [self up_stickersView];
    }
    return self;
}


-(void)up_view
{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *viewBG = [[UIView alloc]initWithFrame:
                       CGRectMake(0, 0, view_width, view_height - 120)];
    [self addSubview:viewBG];
    viewBG.backgroundColor = [UIColor whiteColor];
    
    _viewImg = [[UIImageView alloc]initWithFrame:
                            CGRectMake(
                                       (view_width - (view_width * (view_height - 150 - 64) / view_height)) / 2,
                                       15 + 64,
                                       view_width * (view_height - 150 - 64) / view_height,
                                       view_height - 150 - 64)];
    [viewBG addSubview:_viewImg];
    _viewImg.backgroundColor = [UIColor whiteColor];
    
    _viewImgFramWidth = CGRectGetWidth(_viewImg.frame);
    _viewImgFramHeight = CGRectGetHeight(_viewImg.frame);
    
    NSString *path_temp = NSTemporaryDirectory();
    NSString *imagePath = [path_temp stringByAppendingString:@"screenshotsMap.png"];
    UIImage *getimage = [UIImage imageWithContentsOfFile:imagePath];
    
    _viewImg.image = getimage;
    
#pragma mark - 移动图片
    
    _MovingPictures = [[MapImageViewMovingPictures alloc]initWithFrame:CGRectMake(CGRectGetWidth(_viewImg.frame) - 160, CGRectGetHeight(_viewImg.frame) - 160, 150, 150)];
    [_viewImg addSubview:_MovingPictures];
    
    _MovingPictures.image = mapFilImgArr[0];  //  初始设置
    [_MovingPictures.contentText setTitle:mapFilTitleArr[0] forState:(UIControlStateNormal)];
    
    _viewImg.userInteractionEnabled = YES;
    
    [self addPinchGestureRecognizerToView:_viewImg];
    
    _MovingPictures.userInteractionEnabled = YES;
    _MovingPictures.multipleTouchEnabled = YES;
    
    [self addGestureRecognizerToView:_MovingPictures];
    
}


// 添加手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

- (void) addPinchGestureRecognizerToView:(UIView *)view
{
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (_viewImg.frame.size.width <= _viewImgFramWidth ) {
            [UIView beginAnimations:nil context:nil]; // 开始动画
            [UIView setAnimationDuration:0.5f]; // 动画时长
            view.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);  //  最大放大一倍
            [UIView commitAnimations]; // 提交动画
        }
        if (_viewImg.frame.size.width > _viewImgFramWidth * 2) {
            [UIView beginAnimations:nil context:nil]; // 开始动画
            [UIView setAnimationDuration:0.5f]; // 动画时长
            view.transform = CGAffineTransformMake(2, 0, 0, 2, 0, 0);  //  最大放大两倍
            [UIView commitAnimations]; // 提交动画
        }
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged ) {
        
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        CGPoint newCenter = CGPointMake(view.center.x + translation.x,
                                        view.center.y + translation.y);//    限制屏幕范围：
        newCenter.y = MAX(view.frame.size.height/2, newCenter.y);
        newCenter.y = MIN(_viewImg.frame.size.height - view.frame.size.height/2,  newCenter.y);
        newCenter.x = MAX(view.frame.size.width/2, newCenter.x);
        newCenter.x = MIN(_viewImg.frame.size.width - view.frame.size.width/2,newCenter.x);
        view.center = newCenter;
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}


-(void)up_stickersView
{
    _StickersView = [[UIScrollView alloc]initWithFrame:
                     CGRectMake(0, CGRectGetMaxY(_viewImg.frame) + 15, view_width, 75)];
    [self addSubview:_StickersView];
    _StickersView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CGFloat width = 61;
    
    _StickersView.contentSize = CGSizeMake(
                                         15 + (15 + width) * [mapFilImgArr count],
                                         75);
    
    for (int i = 0 ; i < [mapFilImgArr count]; i++) {
        UIButton *butArr = [[UIButton alloc]initWithFrame:
                            CGRectMake(15 + (15 + width) * i, 7, width, width)];
        [_StickersView addSubview:butArr];
        butArr.backgroundColor = [UIColor whiteColor];
        [butArr setBackgroundImage:mapFilImgArr[i] forState:(UIControlStateNormal)];
        butArr.tag = 100 + i;
        [butArr addTarget:self action:@selector(buttonMapFilImg:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
}

-(void)buttonMapFilImg:(UIButton *)button
{
    _MovingPictures.image = mapFilImgArr[button.tag - 100];  //  初始设置
    [_MovingPictures.contentText setTitle:mapFilTitleArr[button.tag - 100] forState:(UIControlStateNormal)];
}


/**
 *  某个View单独进行截图 ios 控件截图
 */
- (UIImage *)snapshotSingleView:(UIView *)view
{
//    CGRect rect =  view.frame;   //  像素低
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [view.layer renderInContext:context];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
    
    NSData *imageData = [self dataWithScreenshotInPNGFormat:view];
    return [UIImage imageWithData:imageData];
}

-(NSData *)dataWithScreenshotInPNGFormat:(UIView *)view
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = view.bounds.size;
    else
        imageSize = CGSizeMake(view.bounds.size.height, view.bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x - view.frame.origin.x, window.center.y - view.frame.origin.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();  //  关闭上下文
    
    return UIImagePNGRepresentation(image);
}

/**
 *  保存当前图片到本地
 */
-(void)upImageToPhotoAlbum
{
    UIImage *img = [UIImage new];
    
    _viewImg.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);  //  还原图片大小
    
    img = [self snapshotSingleView:_viewImg];
    
    NSLog(@"保存图片到本地");
    
    if (iOS9 || iOS10) {
        [self loadImageFinishedNew:img];
    } else {
        [self loadImageFinished:img];
    }
}

- (void)loadImageFinished:(UIImage *)image  // ios4 ~ios8  引ALAssetsLibrary库,Photos库也可以
{
    __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    [lib writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        
        NSLog(@"assetURL = %@, error = %@", assetURL, error);
        lib = nil;
        
        NSString *msg = nil ;
        if(error != NULL){
            msg = @"保存图片失败" ;
        }else{
            msg = @"保存图片成功，可到相册查看" ;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)loadImageFinishedNew:(UIImage *)image   //  ios8~   引PHPhotoLibrary库
{
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //记录本地标识，等待完成后取到相册中的图片对象
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
        NSString *msg = nil ;
        if(error != NULL){
            msg = @"保存图片失败" ;
        }else{
            msg = @"保存图片成功，可到相册查看" ;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil];
        [alert show];
        
        
        if (success)
        {
            //成功后取相册中的图片对象
            __block PHAsset *imageAsset = nil;
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                imageAsset = obj;
                *stop = YES;
                
            }];
            
            if (imageAsset)
            {
                //加载图片数据
                [[PHImageManager defaultManager] requestImageDataForAsset:imageAsset
                                                                  options:nil
                                                            resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                                
                                                                NSLog(@"imageData = %@", imageData);
                                                                
                                                            }];
            }
        }
        
    }];
}

@end
