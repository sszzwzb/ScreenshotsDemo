//
//  PayAdviceView.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/13.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "PayAdviceView.h"

#import "PlaceholderTextView.h"


#define view_height     [[UIScreen mainScreen] bounds].size.height
#define view_width      [[UIScreen mainScreen] bounds].size.width    //  屏幕的宽高

#define rgba(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define color_gray                              rgba(0,0,0,0.5)

@implementation PayAdviceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self up_view];
    }
    return self;
}

-(void)up_view
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _contentText = [[PlaceholderTextView alloc]initWithFrame:
                    CGRectMake(0.5,
                               0,
                               view_width - 1,
                               200)];
    [self addSubview:_contentText];
    _contentText.textColor = [UIColor blackColor];
    _contentText.font = [UIFont systemFontOfSize:13.f];
    _contentText.placeholder = @"请描述您的问题：";
    _contentText.placeholderColor = [UIColor grayColor];
    
    
    NSString *path_temp = NSTemporaryDirectory();
    NSString *imagePath = [path_temp stringByAppendingString:@"screenshotsPay.png"];
    UIImage *getimage = [UIImage imageWithContentsOfFile:imagePath];
    
    _contentImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 215, view_width / 5, view_height / 5)];
    _contentImg.backgroundColor = [UIColor whiteColor];
    _contentImg.image = getimage;
    [self addSubview:_contentImg];
    
    _contentTextOfNumber = [[UILabel alloc]initWithFrame:
                            CGRectMake(5, CGRectGetMaxY(_contentImg.frame) + 10,
                                       view_width - 10, 15)];
    [self addSubview:_contentTextOfNumber];
    _contentTextOfNumber.font = [UIFont systemFontOfSize:11.f];
    _contentTextOfNumber.textColor = [UIColor grayColor];
    _contentTextOfNumber.textAlignment = NSTextAlignmentRight;
    _contentTextOfNumber.text = @"限定10个字，用于测试（正常的话是240）";
    
}

@end
