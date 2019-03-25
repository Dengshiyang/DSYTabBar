//
//  DSYTabBarController.m
//  DSYTabbar
//
//  Created by 邓石阳 on 2019/3/22.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import "DSYTabBarController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "DSYTabBar.h"
#import "PlusViewController.h"

@interface DSYTabBarController ()

@end

@implementation DSYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildController:homeVC title:@"首页" imageName:@"home" selectedImageName:@"home_blue" navVc:[UINavigationController class]];
    //占位
//    PlusViewController *plusVC = [[PlusViewController alloc] init];
//    [self addChildController:plusVC title:@"" imageName:@"" selectedImageName:@"" navVc:[UINavigationController class]];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    [self addChildController:myVC title:@"我的" imageName:@"mine" selectedImageName:@"mine_blue" navVc:[UINavigationController class]];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 设置自定义的tabbar
    [self setCustomtabbar];
}

- (void)setCustomtabbar{
    
    DSYTabBar *tabbar = [[DSYTabBar alloc] init];
    
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] }forState:UIControlStateSelected];
    
    UINavigationController* nav = [[navVc alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)centerBtnClick:(UIButton *)btn{
    
    NSLog(@"点击了中间");
//    PlusViewController *plusVC = [[PlusViewController alloc] init];
//
//    [self addChildController:plusVC title:@"hao" imageName:nil selectedImageName:nil navVc:[UINavigationController class]];
//    [self presentViewController:plusVC animated:NO completion:nil];
}
@end
