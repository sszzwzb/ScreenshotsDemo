//
//  MapButton.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/16.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "MapButton.h"

@implementation MapButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.tintColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:9.0];
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
                      20,
                      3,
                      27,
                      27);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(
                      13,
                      27,
                      37,
                      contentRect.size.height - 27);
}

-(UIImageView *)StickersImg
{
    if (_StickersImg == nil) {
        _StickersImg = [[UIImageView alloc]initWithFrame:
                        CGRectMake(55, 3, CGRectGetHeight(self.frame) - 6, CGRectGetHeight(self.frame) - 6)];
        [self addSubview:_StickersImg];
        _StickersImg.layer.masksToBounds = YES;
        _StickersImg.layer.cornerRadius = 2;
    }
    return _StickersImg;
}

@end
