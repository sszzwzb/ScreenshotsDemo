//
//  PayAdviceView.h
//  ScreenshotsDemo
//
//  Created by kaiyi on 2017/5/13.
//  Copyright © 2017年 kaiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceholderTextView;

@interface PayAdviceView : UIView

@property(nonatomic,strong) PlaceholderTextView *contentText;
@property(nonatomic,strong) UIImageView *contentImg;

@property(nonatomic,strong) UILabel *contentTextOfNumber;

@end
