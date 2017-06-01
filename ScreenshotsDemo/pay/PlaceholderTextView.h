//
//  PlaceholderTextView.h
//  ShoppingAPP
//
//  Created by kaiyi on 16/11/14.
//  Copyright © 2016年 kaiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

@property (nonatomic, strong) UILabel * placeHolderLabel;

@property (nonatomic, copy) NSString * placeholder;

@property (nonatomic, strong) UIColor * placeholderColor;

- (void)textChanged:(NSNotification * )notification;

@end
