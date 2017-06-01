//
//  payView.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/13.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "payView.h"

#import "payButton.h"


#define view_height     [[UIScreen mainScreen] bounds].size.height
#define view_width      [[UIScreen mainScreen] bounds].size.width    //  屏幕的宽高

#define rgba(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define color_gray                              rgba(0,0,0,0.5)

#define time1  1.f
#define time2  7.f

@interface payView()

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation payView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self up_view];
        [self userDidTakeScreenshotAction];
    }
    return self;
}


-(void)up_view
{
    if (_screenshotsSideButton == nil) {
        _screenshotsSideButton = [payButton buttonWithType:(UIButtonTypeCustom)];
        _screenshotsSideButton.frame = CGRectMake(view_width + 10, view_height / 2 - 22, 100, 40);
        _screenshotsSideButton.backgroundColor = color_gray;
        
        
        [_screenshotsSideButton setImage:[UIImage imageNamed:@"pay"] forState:(UIControlStateNormal)];
        [_screenshotsSideButton setTitle:@"我要建议" forState:(UIControlStateNormal)];
        [_screenshotsSideButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [_screenshotsSideButton addTarget:self action:@selector(payButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_screenshotsSideButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(20, 20)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = _screenshotsSideButton.bounds;
        
        maskLayer.path = maskPath.CGPath;
        
        _screenshotsSideButton.layer.mask = maskLayer;
        
        _screenshotsSideButton.userInteractionEnabled = YES;
        
        [[UIApplication sharedApplication].keyWindow addSubview:_screenshotsSideButton];
    }
}


-(void)userDidTakeScreenshotAction
{
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];
}

//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification
{
    NSLog(@"检测到截屏");
    
    [UIView animateWithDuration:time1 animations:^{
        
        _screenshotsSideButton.transform=CGAffineTransformMakeTranslation( -110, 0);
        
    }];
    

    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
    
    NSString *path_temp = NSTemporaryDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_temp stringByAppendingString:@"screenshotsPay.png"];
    [UIImagePNGRepresentation(image_) writeToFile:imagePath atomically:YES];
    
    NSLog(@"%@",imagePath);
  
    _timer = [NSTimer  scheduledTimerWithTimeInterval:time2 target:self selector:@selector(screenshotsSideButtonHidden) userInfo:nil repeats:NO];
    
    
//    //添加显示
//    UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image_];
//    imgvPhoto.frame = CGRectMake(100,100,100,100);
//    
//    //添加边框
//    CALayer * layer = [imgvPhoto layer];
//    layer.borderColor = [[UIColor whiteColor] CGColor];
//    layer.borderWidth = 5.0f;
//    //添加四个边阴影
//    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
//    imgvPhoto.layer.shadowOffset = CGSizeMake(0, 0);
//    imgvPhoto.layer.shadowOpacity = 0.5;
//    imgvPhoto.layer.shadowRadius = 10.0;
//    //添加两个边阴影
//    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
//    imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
//    imgvPhoto.layer.shadowOpacity = 0.5;
//    imgvPhoto.layer.shadowRadius = 2.0;
//    
//    [self addSubview:imgvPhoto];
}

/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
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
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}



-(void)payButtonAction:(payButton *)button
{
    _screenshotsSideButton.transform=CGAffineTransformMakeTranslation(110, 0);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"presentPayAdviceViewController" object:nil userInfo:nil];
}

-(void)screenshotsSideButtonHidden
{
    [UIView animateWithDuration:time1 animations:^{
        
        _screenshotsSideButton.transform=CGAffineTransformMakeTranslation(110, 0);
        
    }];
    
    [_timer invalidate];
    _timer = nil;
}


@end
