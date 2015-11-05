//
//  DealBaseListController.m
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealBaseListController.h"
#import "DealCell.h"
#import "DealModel.h"
//#import "Cover.h"
//#import "DealDetailController.h"
//#import "XNavigationController.h"
//#import "UIBarButtonItem+X.h"

#define kItemCellHeight 250
#define kItemCellWidth 250

@interface DealBaseListController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation DealBaseListController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自己的UICollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kItemCellWidth, kItemCellHeight); //每一个网格的尺寸
    layout.minimumLineSpacing = 20.0; //每一行之间的距离
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    //注册cell要用的xib
    //bundle:nil 默认去mainbundle中去找
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    
    //设置collectionView永远支持垂直滚动
    self.collectionView.alwaysBounceVertical = YES;
    
    //设置背景色
    //self.tableView == self.view
    //self.collectionView == self.view中的一个子控件
    self.collectionView.backgroundColor = kGlobalBackgroundColor;
}

#pragma mark 在viewWillAppear和viewDidAppear中可以取得view最准确的宽高
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //默认计算间距
    [self didRotateFromInterfaceOrientation:0];
}

//#pragma mark 屏幕即将旋转的时候调用(控制器监听屏幕旋转)
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//
//}

#pragma mark 屏幕旋转结束
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //取出layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    //计算间距
    CGFloat vertical = 20.0;
    CGFloat horizontal = 0;
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){ //横屏
        horizontal = (self.view.frame.size.width - 3 * kItemCellWidth) / 4;
    }else{
        horizontal = (self.view.frame.size.width - 2 * kItemCellWidth) / 3;
    }
    
    [UIView animateWithDuration:2.0 animations:^{
        layout.sectionInset = UIEdgeInsetsMake(vertical, horizontal, vertical, horizontal); //上下左右的间距
    }];
    
}

#pragma mark - 移除通知
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:self.totalDeals[indexPath.row]];
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalDeals.count;
}

#pragma mark 刷新数据的时候会调用（reloadData）,每当有一个cell重新进入屏幕视野范围内会调用
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"deal";
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.deal = self.totalDeals[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
