//
//  BDJTabBarController.m
//  百思不得姐
//
//  Created by ZL on 16/11/21.
//  Copyright © 2016年 ZL. All rights reserved.
//

#import "BDJTabBarController.h"
#import "BDJTabBar.h"
#import "BDJMenu.h"
#import "EssenceViewController.h"
#import "NewsViewController.h"


@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改tabBar背景颜色
    //    self.tabBar.barTintColor = [UIColor colorWithWhite:64.0f/255.0f alpha:1.0f];
    //    self.tabBar.tintColor = [UIColor colorWithWhite:64.0f/255.0f alpha:1.0f];
    //修改全部颜色
    [UITabBar appearance].tintColor = [UIColor colorWithWhite:64.0f/255.0f alpha:1.0f];
    
    //使用自定制的TabBar
    [self setValue:[[BDJTabBar alloc] init] forKey:@"tabBar"];
    
    //创建视图控制器
    [self createViewControllers];
    
    //获取菜单数据
    [self loadMenuData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

//获取菜单数据
- (void)loadMenuData {
    
    NSString *filePath = [self menuFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //读文件
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        BDJMenu *menu = [[BDJMenu alloc] initWithData:data error:nil];
        
        //显示
        [self showAllMenuData:menu];
    }
    
    
    //更新菜单数据
    [self downloadMenuData];
    
}

//下载菜单数据
- (void)downloadMenuData {
    //http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/
    
    [BDJDownloader downloadWithURLString:@"http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/" success:^(NSData *data) {
        NSLog(@"====");
        //解析
        BDJMenu * menu = [[BDJMenu alloc] initWithData:data error:nil];
        
        NSString *path = [self menuFilePath];
        
        //如果plist文件不存在，显示菜单数据
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [self showAllMenuData:menu];
        }
        
        //存到本地
        [data writeToFile:path atomically:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

//本地存储菜单数据的文件名
- (NSString *)menuFilePath {
    NSString *docPath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //下面的path是路径，自带/
    return [docPath stringByAppendingPathComponent:@"menu.plist"];
}

//显示菜单数据
- (void)showAllMenuData:(BDJMenu *)menu {
    
    //设置精华的菜单数据
    UINavigationController *essenceNavCtrl = [self.viewControllers firstObject];
    EssenceViewController *essenceCtrl = [essenceNavCtrl.viewControllers firstObject];
    
    essenceCtrl.subMenus = [[menu.menus firstObject] submenus];
    
    //设置最新的界面菜单数据
    if (self.viewControllers.count >= 2) {
        UINavigationController *newsNavCtrl = self.viewControllers[1];
        NewsViewController *newsCtrl = [newsNavCtrl.viewControllers firstObject];
        if (menu.menus.count >= 2) {
            newsCtrl.subMenus = [menu.menus[1] submenus];
        }
    }
}

//创建视图控制器
- (void)createViewControllers {
    
    //1.精华
    [self addSubControllers:@"EssenceViewController" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon" title:@"精华"];
    
    //2.最新
    [self addSubControllers:@"NewsViewController" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon" title:@"最新"];
    
    //3.添加
    
    //4.关注
    [self addSubControllers:@"AttentionViewController" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    //5.我的
    [self addSubControllers:@"ProfileViewController" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon" title:@"我的"];
}

//添加单个的视图控制器
- (void)addSubControllers:(NSString *)ctrlName imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName title:(NSString *)title {
    
    //1.创建视图控制器对象
    Class cls = NSClassFromString(ctrlName);
    UIViewController *tmpCtrl = [[cls alloc] init];
    
    //2.设置文字
    tmpCtrl.tabBarItem.title = title;
    
    //3.图片
    tmpCtrl.tabBarItem.image = [UIImage imageNamed:imageName];
    tmpCtrl.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    //4.导航
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:tmpCtrl];
    
    //5.让tabBarCtrl管理这个视图控制器
    //添加子视图控制器,按先后顺序
    [self addChildViewController:navCtrl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
