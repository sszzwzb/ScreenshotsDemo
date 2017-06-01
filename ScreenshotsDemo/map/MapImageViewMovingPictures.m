//
//  MapImageViewMovingPictures.m
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/17.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import "MapImageViewMovingPictures.h"

#define view_height     [[UIScreen mainScreen] bounds].size.height
#define view_width      [[UIScreen mainScreen] bounds].size.width    //  屏幕的宽高

#define rgba(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define color_gray                              rgba(0,0,0,0.5)

@interface MapImageViewMovingPictures () <UITextFieldDelegate>

@property(nonatomic,strong) UIView *WindowView;

@property(nonatomic,strong) UITextField *contentTextF;

@end

@implementation MapImageViewMovingPictures

-(UIButton *)contentText
{
    if (_contentText == nil) {
        _contentText = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _contentText.frame = CGRectMake(5, 20, 80, 40);
        [self addSubview:_contentText];
        
        _contentText.backgroundColor = [UIColor clearColor];
        
        [_contentText setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        _contentText.titleLabel.font = [UIFont systemFontOfSize:13.f];
        _contentText.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:13.f];
        _contentText.titleLabel.numberOfLines = 3;
        _contentText.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [_contentText addTarget:self action:@selector(contentTextAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        _WindowView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [[UIApplication sharedApplication].keyWindow  addSubview:_WindowView];
        _WindowView.backgroundColor = color_gray;
        _WindowView.hidden = YES;
        
        
        _contentTextF = [[UITextField alloc]initWithFrame:
                        CGRectMake(40, view_height / 2 - 60, view_width - 80, 60)];
        [_WindowView addSubview:_contentTextF];
        _contentTextF.backgroundColor = [UIColor whiteColor];
        _contentTextF.delegate = self;
        
        _contentTextF.returnKeyType = UIReturnKeyDone;  //   键盘确认
        _contentTextF.borderStyle = UITextBorderStyleBezel;  //  边框
        _contentTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _contentTextF.layer.masksToBounds = YES;
        _contentTextF.layer.cornerRadius = 10;
        
        
        _contentTextF.text = [_contentText currentTitle];  //  获取按键上的文字
        
    }
    return _contentText;
}

-(void)contentTextAction
{
    if (_WindowView.hidden == YES) {
        _WindowView.hidden = NO;
        
        _contentTextF.text = [_contentText currentTitle];  //  获取按键上的文字
        [_contentTextF becomeFirstResponder];  //  打开键盘
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]>0) {
        [textField resignFirstResponder];
        NSString *text = _contentTextF.text;
        [_contentText setTitle:text forState:(UIControlStateNormal)];
        _WindowView.hidden = YES;
    }
    return YES;
}




@end
