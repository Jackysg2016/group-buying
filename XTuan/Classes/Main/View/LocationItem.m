//
//  LocationItem.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "LocationItem.h"
#import "CityListController.h"
#import "City.h"
#import "MetaDataTool.h"
#import "LocationTool.h"

#define kImageScale 0.55

@interface LocationItem ()
{
    UIPopoverController *_popover;
    UIActivityIndicatorView *_indicator;
}


@end

@implementation LocationItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        //2.设置图片
//        [self setIcon:@"ic_district.png" selectedIcon:@"ic_district_hl.png"];
        
        //3.设置默认的文字
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //4.设置图片属性
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //5.监听点击
        [self addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchDown];
        
        //6.监听城市改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
        
        //加载城市信息
        [self loadCityData];
         
    }
    return self;
}

#pragma mark 加载城市信息
-(void)loadCityData
 {
     //添加圈圈
     UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
     indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
     CGFloat x = kDockItemWidth * 0.5;
     CGFloat y = kDockItemHeight * 0.35;
     indicator.center = CGPointMake(x, y);
     [self addSubview:indicator];
     [indicator startAnimating];
     _indicator = indicator;
     
     //
     [LocationTool sharedLocationTool];
     
 }

#pragma mark 城市改变
-(void)cityChange
{
    City *city = [MetaDataTool sharedMetaDataTool].currentCity;
    
    //更改显示的城市名称
    [self setTitle:city.name forState:UIControlStateNormal];
    
    //关闭popover（代码关闭popover不会触发代理方法）
    [_popover dismissPopoverAnimated:YES];
    
    //变为enable
    self.enabled = YES;
    
    //移除圈圈
    [_indicator removeFromSuperview];
    _indicator = nil;
    
    //设置图片
    [self setIcon:@"ic_district.png" selectedIcon:@"ic_district_hl.png"];
}

//-(void)screenRotate
//{
//    XLog(@"屏幕旋转");
//    if (_popover.popoverVisible) {
//        //关闭之前的
//        [_popover dismissPopoverAnimated:NO];
//        
//        //再显示
//        [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
//    
//}

-(void)locationClick
{
    CityListController *city = [[CityListController alloc] init];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:city];
    _popover.popoverContentSize = CGSizeMake(320, 480);
    //下面两种方式效果一样
    //[popover presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
//    //监听屏幕旋转的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * kImageScale;
    return CGRectMake(0, 0, w, h);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * (1 - kImageScale);
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, w, h);
}

@end
