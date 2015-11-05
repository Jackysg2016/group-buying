//
//  MainController.m
//  XTuan
//
//  Created by dengwei on 15/8/13.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "DealListController.h"
#import "MapController.h"
#import "CollectController.h"
#import "MineController.h"
#import "XNavigationController.h"

@interface MainController ()<DockDelegate>
{
    UIView *_contentView;
}

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //XLog(@"frame %@", NSStringFromCGRect(self.view.frame));
    
    //self.view.backgroundColor = [UIColor redColor];
    
    //添加dock
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    dock.delegate = self;
    [self.view addSubview:dock];
    
    //添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - kDockItemWidth;
    CGFloat h = self.view.frame.size.height;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.frame = CGRectMake(kDockItemWidth, 0, w, h);
    [self.view addSubview:_contentView];
    
    //添加子控制器
    [self addAllChildControllers];
}

#pragma mark 添加子控制器
-(void)addAllChildControllers
{
    //1.团购
    DealListController *deal = [[DealListController alloc] init];
    XNavigationController *dealNav = [[XNavigationController alloc] initWithRootViewController:deal];
    [self addChildViewController:dealNav];
    
    //2.地图
    MapController *map = [[MapController alloc] init];
    map.view.backgroundColor = [UIColor yellowColor];
    XNavigationController *mapNav = [[XNavigationController alloc] initWithRootViewController:map];
    [self addChildViewController:mapNav];
    
    //3.收藏
    CollectController *collect = [[CollectController alloc] init];
    XNavigationController *collectNav = [[XNavigationController alloc] initWithRootViewController:collect];
    [self addChildViewController:collectNav];
    
    //4.我的
    MineController *mine = [[MineController alloc] init];
    mine.view.backgroundColor = kGlobalBackgroundColor;
    XNavigationController *mineNav = [[XNavigationController alloc] initWithRootViewController:mine];
    [self addChildViewController:mineNav];
    
    //5.默认选中团购控制器
    [self dock:nil tabChangedFrom:0 to:0];
}

#pragma mark 点击了Dock上的某个标签
-(void)dock:(Dock *)dock tabChangedFrom:(int)from to:(int)to
{
    //XLog(@"from %d to %d", from, to);
    //XLog(@"w %f h %f", self.view.frame.size.width, self.view.frame.size.height);
    //1.移除旧的
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    //2.添加新的
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    new.view.frame = _contentView.bounds;
    [_contentView addSubview:new.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
