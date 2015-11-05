//
//  DealDetailController.m
//  XTuan
//
//  Created by dengwei on 15/8/18.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealDetailController.h"
#import "DealModel.h"
#import "UIBarButtonItem+X.h"
#import "BuyDock.h"
#import "DetailDock.h"
#import "DealInfoController.h"
#import "DealWebController.h"
#import "DealMerchantController.h"
#import "CollectTool.h"

@interface DealDetailController ()<DetailDockDelegate>
{
    DetailDock *_detailDock;
}

@end

@implementation DealDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //基本设置
    [self baseSetting];
    
    //添加顶部购买栏
    [self addBuyDock];
    
    //添加右边选项卡栏
    [self addDetailDock];
    
    //初始化子控制器
    [self addAllChildControllers];
    
}

#pragma mark 初始化子控制器
-(void)addAllChildControllers
 {
     //团购简介
     DealInfoController *info = [[DealInfoController alloc]initWithDeal:_deal];
     //info.deal = _deal;
     [self addChildViewController:info];
     //默认选中第0个
     [self detailDock:nil btnClickFrom:0 to:0];
     
     //图文详情
     DealWebController *web = [[DealWebController alloc]init];
     web.deal = _deal;
     [self addChildViewController:web];
     
     //商家详情
     DealMerchantController *merchant = [[DealMerchantController alloc]init];
     merchant.view.backgroundColor = [UIColor greenColor];
     [self addChildViewController:merchant];
 }

#pragma mark 添加顶部购买栏
-(void)addBuyDock
{
    BuyDock *dock = [BuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, kBottomMenuY, self.view.frame.size.width, 70);
    [self.view addSubview:dock];
}

#pragma mark detailDock代理方法
-(void)detailDock:(DetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
    //移除旧的
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    //添加新的
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    CGFloat w = self.view.frame.size.width - _detailDock.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    new.view.frame = CGRectMake(0, 0, w, h);
    [self.view insertSubview:new.view atIndex:0];
}

#pragma mark 添加右边选项卡栏
-(void)addDetailDock
{
    DetailDock *dock = [DetailDock detailDock];
    CGSize size = dock.frame.size;
    CGFloat x = self.view.frame.size.width - size.width;
    CGFloat y = self.view.frame.size.height * 0.3;
    dock.frame = CGRectMake(x, y, 0, 0);
    dock.delegate = self;
    [self.view addSubview:dock];
    _detailDock = dock;
}

#pragma mark 基本设置
-(void)baseSetting
{
    //背景色
    self.view.backgroundColor = kGlobalBackgroundColor;
    
    //标题
    self.title = _deal.title;
    
    //处理团购的收藏属性
    [[CollectTool sharedCollectTool] handleDeal:_deal];
    
    //右边按钮
    NSString *collectionIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";
    self.navigationItem.rightBarButtonItems = @[
    [UIBarButtonItem itemWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" target:nil action:nil],
    [UIBarButtonItem itemWithIcon:collectionIcon highlightedIcon:@"ic_deal_collect_pressed.png" target:self action:@selector(collect)]];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectChanged) name:kCollectChangeNote object:nil];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toBuyDeal) name:kToBuyDealNote object:nil];
    
}

-(void)toBuyDeal
{
    [self detailDock:nil btnClickFrom:0 to:1];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBuyDealNote object:nil];
}

#pragma mark 收藏
-(void)collect
{
    if (_deal.collected) {  //已经收藏过
        [[CollectTool sharedCollectTool] uncollectDeal:_deal];
        
    }else{
        [[CollectTool sharedCollectTool] collectDeal:_deal];
        
    }
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNote object:nil];
}

#pragma mark 移除通知
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 收藏状态改变
-(void)collectChanged
{
    [[CollectTool sharedCollectTool] handleDeal:_deal];
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    
    if(_deal.collected){
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
