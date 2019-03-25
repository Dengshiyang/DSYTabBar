//
//  PlusViewController.m
//  DSYTabbar
//
//  Created by 邓石阳 on 2019/3/22.
//  Copyright © 2019 邓石阳. All rights reserved.
//

#import "PlusViewController.h"
#import <WebKit/WebKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f&& kIs_iphone
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

@interface PlusViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;
@end

@implementation PlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc]init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    config.preferences = preference;
//    [YhbMethods setNavMainColor:self.navigationController];
    //设置网页webView
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavAndTabHeight) configuration:config];
    // UI代理
//    _webView.UIDelegate = self;
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:@"商城"];
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    
    //刷新当前页面
    [_webView reload];
    
    NSURL *url = [NSURL URLWithString:@"https://h5test.bgyfhyx.com/bh/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

#pragma -- WKWebView代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    //    NSString *url = navigationAction.request.URL.absoluteString;
    //    if ([url isEqualToString:@"https://www.baidu.com/"]) {
    //
    //    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            //sets both of these
//            self.title = self.webView.title;
            
            //sets navigation bar title.
            self.navigationItem.title = self.webView.title;
            
            //sets tab bar title
            self.navigationController.title = @"商城";
//            self.tabBarItem.title = @"商城";
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
    }
}

@end
