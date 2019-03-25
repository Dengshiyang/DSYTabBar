//
//  DSYViewController.m
//  MCTabbar
//
//  Created by 邓石阳 on 2019/3/25.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import "DSYViewController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "PlusViewController.h"

@interface DSYViewController ()<MCTabBarControllerDelegate>

@end

@implementation DSYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    self.mcTabbar.translucent = NO;
    self.mcTabbar.centerImage = [UIImage imageNamed:@"plus"];
    //选中时的颜色
    self.mcTabbar.tintColor = [UIColor colorWithRed:42.0/255.0 green:166.0/255.0 blue:134/255.0 alpha:1];
    self.mcDelegate = self;
    self.mcTabbar.position = MCTabBarCenterButtonPositionBulge;
    [self addChildViewControllers];
}

//添加子控制器
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[HomeViewController alloc] init] andTitle:@"首页" andImageName:@"home"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[PlusViewController alloc] init] andTitle:@"商城" andImageName:@""];
    [self addChildrenViewController:[[MyViewController alloc] init] andTitle:@"我的" andImageName:@"mine"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    // 选中的颜色由tabbar的tintColor决定
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:imageName];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}

// 使用MCTabBarController 自定义的 选中代理
- (void)mcTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 1){
        [self rotationAnimation];
    }else {
        [self.mcTabbar.centerBtn.layer removeAllAnimations];
    }
}

//旋转动画
- (void)rotationAnimation{
    if ([@"key" isEqualToString:[self.mcTabbar.centerBtn.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
//    rotationAnimation.repeatCount = HUGE;
    [self.mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

@end
