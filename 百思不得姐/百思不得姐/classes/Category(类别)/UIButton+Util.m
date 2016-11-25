//
//  UIButton+Util.m
//  百思不得姐
//
//  Created by ZL on 16/11/21.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)

+ (UIButton *)createBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName highlightBgImageName:(NSString *)highlightBgImageName target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [btn setImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (highlightBgImageName) {
        [btn setImage:[UIImage imageNamed:highlightBgImageName] forState:UIControlStateHighlighted];
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

@end
