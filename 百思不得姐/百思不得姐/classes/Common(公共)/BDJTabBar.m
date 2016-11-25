//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by ZL on 16/11/21.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "BDJTabBar.h"

@implementation BDJTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//重新实现初始化方法
- (instancetype)init {
    
    if (self = [super init]) {
        
        UIButton *addBtn = [UIButton createBtnTitle:nil bgImageName:@"tabBar_publish_icon" highlightBgImageName:@"tabBar_publish_click_icon" target:self action:@selector(publishAction)];
        [self addSubview:addBtn];
        
    }
    return self;
}

- (void)publishAction {
    NSLog(@"发布....");
}
/*
 在什么时候子视图会重新布局
 1.视图显示到父视图上面的时候
 2.手动调用了视图对象的layoutIfNeed方法
 */
/*在当前对象的子视图重新布局的时候调用*/
-(void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"%s",__FUNCTION__);
    //修改按钮的位置
    //注意:这里不能使用约束的方式修改
    
    
    //按钮的宽度
    CGFloat btnW = kScreenWidth/5;
    //遍历系统UITabBarButton的序号
    NSInteger index = 0;
    for (UIView *tmpView in self.subviews) {
        //发布按钮
        if ([tmpView isKindOfClass:[UIButton class]]) {
//            tmpView.frame = CGRectMake(btnW*2, 4, btnW, 40);
            tmpView.center = CGPointMake(kScreenWidth/2, 49.0f/2);
            
            tmpView.size = CGSizeMake(40, 40);
            
        }else if ([tmpView isKindOfClass: NSClassFromString(@"UITabBarButton")]) {
            
            tmpView.width = btnW;
            
            if (index >= 2) {
                //第三个需要添加按钮的宽度值
                tmpView.x = (index+1)*btnW;
            }else {
                tmpView.x = index*btnW;
            }
            
            
            
            index++;
        }
    }
    
    
}



@end
