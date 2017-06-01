//
//  payButton.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/13.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "payButton.h"

@implementation payButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.tintColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
        // 设置显示的内容居中
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置显示的文字居中显示
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        // 设置图片的大小自适应
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(
                      15,
                      (contentRect.size.height - 23 ) / 2,
                      23,
                      23);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(
                      42 ,
                      0,
                      contentRect.size.width - 42,
                      contentRect.size.height);
}


@end
