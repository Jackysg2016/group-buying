//
//  MapController.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "MapController.h"
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DealTool.h"
#import "DealPosAnnotationModel.h"
#import "DealModel.h"
#import "BusinessModel.h"
#import "MetaDataTool.h"

#define kSpan MKCoordinateSpanMake(0.018404, 0.031468)

@interface MapController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    NSMutableArray *_showingDeals;
}

@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"地图";
    
    //添加地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //显示用户位置
    mapView.showsUserLocation = YES;
    // 设置代理
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    //初始化数据
    _showingDeals = [NSMutableArray array];
    
    //添加回到用户位置的按钮
    UIButton *backUser = [UIButton buttonWithType:UIButtonTypeCustom];
    [backUser setImage:[UIImage imageNamed:@"btn_map_locate.png"] forState:UIControlStateNormal];
    CGFloat w = 59;
    CGFloat h = 59;
    CGFloat x = self.view.frame.size.width - w - 30;
    CGFloat y = self.view.frame.size.height - h - 30;
    backUser.frame = CGRectMake(x, y, w, h);
    backUser.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [backUser addTarget:self action:@selector(backUserClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUser];
    
}

-(void)backUserClick
{
    CLLocationCoordinate2D center = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    [_mapView setRegion:region animated:YES];
    
    XLog(@"回到当前位置:%f", center.longitude);
}

#pragma mark - mapView代理方法
#pragma mark 当定位到用户的位置就会调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_mapView) {
        return;
    }
    
    //位置
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    //跨度（范围）
    //MKCoordinateSpan span = MKCoordinateSpanMake(0.018404, 0.031468);
    //区域
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    
    [mapView setRegion:region animated:YES];
    //[mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    _mapView = mapView;
    
    XLog(@"定位到用户的位置");
}

#pragma mark 拖动地图（地图展示的区域改变了）就会调用
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    //地图当前显示区域的中心位置
    CLLocationCoordinate2D pos = mapView.region.center;
    
    [[DealTool sharedDealTool] dealsWithPostion:pos success:^(NSArray *deals, int totalCount) {
        for (DealModel *deal in deals) {
            //已经显示过这家团购
            if ([_showingDeals containsObject:deal]) {
                continue;
            }
            
            //从未显示过
            [_showingDeals addObject:deal];
            
            for (BusinessModel *b in deal.businesses) {
                
                DealPosAnnotationModel *annotation = [[DealPosAnnotationModel alloc]init];
                annotation.business = b;
                annotation.deal = deal;
                annotation.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:annotation];
            }
            
        }
    } failure:^(NSError *error) {
        XLog(@"error:%@", error);
    }];
    
    XLog(@"拖动地图");
}

#pragma mark 设置大头针
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(DealPosAnnotationModel *)annotation
{
    if (![annotation isKindOfClass:[DealPosAnnotationModel class]]) {
        return nil;
    }
    
    //从缓存池中取出大头针view
    static NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    //缓存池没有可循环利用的大头针view
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    //设置大头针信息
    annotationView.annotation = annotation;
    
    //设置图片
    annotationView.image = [UIImage imageNamed:annotation.icon];
    
    return annotationView;
}

#pragma mark 点击大头针
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //展示详情
    DealPosAnnotationModel *anno = view.annotation;
    [self showDetail:anno.deal];
    
    //让选中的大头针居中
    [mapView setCenterCoordinate:anno.coordinate animated:YES];
    
    //让view周边产生一些阴影
    //阴影颜色
    view.layer.shadowColor = [UIColor redColor].CGColor;
    //阴影透明度
    view.layer.shadowOpacity = 1;
    //阴影范围，值越大范围越广
    view.layer.shadowRadius = 2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
