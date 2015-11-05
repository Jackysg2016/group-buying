//
//  DealListController.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealListController.h"
#import "DealTopMenu.h"
#import "MetaDataTool.h"
#import "City.h"
#import "DealModel.h"
#import "NSObject+Value.h"
#import "DealTool.h"
#import "MJRefresh.h"
#import "ImageTool.h"

#import "DealDetailController.h"
#import "XNavigationController.h"
#import "UIBarButtonItem+X.h"



@interface DealListController ()<MJRefreshBaseViewDelegate>
{
    NSMutableArray *_deals;
    int _page; //页码
    MJRefreshFooterView *_footer;
    MJRefreshHeaderView *_header;
    
}

@end

@implementation DealListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //基本设置
    [self baseSettings];
    
    //添加刷新控件
    [self addRefresh];
    
    //默认选中北京,调试使用
    [MetaDataTool sharedMetaDataTool].currentCity = [MetaDataTool sharedMetaDataTool].totalCities[@"北京"];
    
}

-(NSArray *)totalDeals
{
    return _deals;
}

#pragma mark - 刷新的代理方法
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshHeaderView class]];
    if (isHeader) { //下拉刷新
        //清除图片缓存
        [ImageTool clearImageCache];
        
        _page = 1;//第一页
        
    }else{ //上拉加载更多
        _page++;//第一页
        
    }
    
    [[DealTool sharedDealTool ]dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
        if (isHeader) {
            _deals = [NSMutableArray array];
        }
        //添加数据
        [_deals addObjectsFromArray:deals];
        
        //刷新表格
        [_collectionView reloadData];
        //恢复刷新状态
        [refreshView endRefreshing];
        //根据数量判断是否需要隐藏上拉控件
        _footer.hidden = _deals.count >= totalCount;
        
    } failure:^(NSError *error) {
        XLog(@"error %@", error);
        //恢复刷新状态
        [refreshView endRefreshing];
    }];
}

#pragma mark 添加刷新控件
-(void)addRefresh
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _collectionView;
    header.delegate = self;
    _header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _collectionView;
    footer.delegate = self;
    _footer = footer;
}

#pragma mark 基本设置
-(void)baseSettings
{
    //1.监听城市改变的通知
    kAddAllNotes(dataChanged)
    
    //2.右边的搜索框
    UISearchBar *search = [[UISearchBar alloc]init];
    search.frame = CGRectMake(0, 0, 200, 35);
    search.placeholder = @"请输入商品名,地址等";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    
    //3.左边菜单栏
    DealTopMenu *top = [[DealTopMenu alloc]init];
    top.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:top];
    
}

-(void)dataChanged
{
//    _deals = [NSMutableArray array];
//    _page = 1;//第一页
//    [[DealTool sharedDealTool ]dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
//        [_deals addObjectsFromArray:deals];
//        
//        [self.collectionView reloadData];
//    } failure:^(NSError *error) {
//        XLog(@"error %@", error);
//    }];
    [_header beginRefreshing];

}

#pragma mark - 内存告警
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
