//
//  BaseShowDetailController.m
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "BaseShowDetailController.h"
#import "Cover.h"
#import "DealDetailController.h"
#import "XNavigationController.h"
#import "UIBarButtonItem+X.h"

#define kDetailWidth 600

@interface BaseShowDetailController ()
{
    Cover *_cover;
}

@end

@implementation BaseShowDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark 展示详情控制器
-(void)showDetail:(DealModel *)deal
{
    //显示遮盖
    if (_cover == nil) {
        _cover = [Cover coverWithTarget:self action:@selector(hideDetail)];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
    //展示详情控制器
    DealDetailController *detail = [[DealDetailController alloc]init];
    //左边按钮
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    XNavigationController *nav = [[XNavigationController alloc] initWithRootViewController:detail];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    
    //监听拖拽
    [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
    
    //当两个控制器互为父子关系时，它们的view也是互为父子关系
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
    
}

-(void)drag:(UIPanGestureRecognizer *)pan
{
    
    CGFloat tx = [pan translationInView:pan.view].x;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat halfW = pan.view.frame.size.width * 0.5;
        
        if (tx >= halfW) { //已经往右挪动超过一半，应该隐藏
            [self hideDetail];
        }else{
            [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    }else{ //移动控制器的view
        if (tx < 0) { //向左边拖拽
            tx *= 0.3; //弹簧效果
        }
        
        pan.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    }
    
}

#pragma mark 隐藏详情控制器
-(void)hideDetail
{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        //隐藏遮盖
        _cover.alpha = 0;
        
        //隐藏控制器
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
        
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
