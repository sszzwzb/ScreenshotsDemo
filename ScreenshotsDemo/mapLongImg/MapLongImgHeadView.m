//
//  MapLongImgHeadView.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/18.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "MapLongImgHeadView.h"


#define view_height     [[UIScreen mainScreen] bounds].size.height
#define view_width      [[UIScreen mainScreen] bounds].size.width    //  屏幕的宽高

#define height_headViewHeight   90

@implementation MapLongImgHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self up_headView];
    }
    return self;
}

-(void)up_headView
{
    self.backgroundColor = [UIColor whiteColor];
    
    _headViewBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _headViewBut.frame = CGRectMake(0, 0, view_width, height_headViewHeight);
    [self addSubview:_headViewBut];
    
    [_headViewBut setTitle:@"点击隐藏/显示 cell" forState:(UIControlStateNormal)];
    
    _headViewBut.backgroundColor = [UIColor whiteColor];
    
}

+ (float) headViewHeight
{
    return height_headViewHeight;
}

@end
