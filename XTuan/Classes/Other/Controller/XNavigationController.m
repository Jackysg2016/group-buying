//
//  XNavigationController.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "XNavigationController.h"
#import "UIImage+X.h"

@interface XNavigationController ()

@end

@implementation XNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark 第一次使用这个类的时候调用
+(void)initialize
{
    //修改来这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置导航栏的背景图片
    [bar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_navigation.png"]]];
    
    
    //修改所有UIBarButtonItem外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right_hl.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //修改文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:17.0];
    [barItem setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    //设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark 当类被加载时使用
+(void)load
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
