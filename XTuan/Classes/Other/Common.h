//
//  Common.h
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#ifndef XTuan_Common_h
#define XTuan_Common_h

//自定义日志输出
#ifdef DEBUG
//调试状态
#define XLog(...) NSLog(@"%s line:%d\n %@ \n\n", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
//发布状态
#define XLog(...)
#endif

/**
 *  系统导航栏高度
 */
#define kNavigationBarHeight 20

/**
 *  Dock上条目的尺寸
 */
#define kDockItemWidth 100
#define kDockItemHeight 80

/**
 *  顶部菜单尺寸
 */
#define kTopMenuItemWidth 110
#define kTopMenuItemHeight 44

/**
 *  底部菜单尺寸
 */
#define kBottomMenuItemWidth 110
#define kBottomMenuItemHeight 70
#define kBottomMenuY 64

// 通知名称
// 城市改变的通知
#define kCityChangeNote @"city_change"
// 区域改变的通知
#define kDistrictChangeNote @"district_change"
// 分类改变的通知
#define kCategoryChangeNote @"category_change"
// 排序改变的通知
#define kOrderChangeNote @"order_change"
// 收藏改变的通知
#define kCollectChangeNote @"collect_change"
// 购买团购的通知
#define kBuyDealNote @"buy_deal"
// 跳到购买团购页面的通知
#define kToBuyDealNote @"to_buy_deal"

//添加所有监听通知
#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];

// 城市的key
#define kCityKey @"city"

//全局背景色
#define kGlobalBackgroundColor [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]

//默认动画时间
#define kDefaultAnimationDuration 0.4

//固定字符串
#define kAllCategoryStr @"全部分类"
#define kAllDistrictStr @"全部商区"
#define kAllStr @"全部"

//每页返回的团单结果条目数上限，最小值1，最大值40，默认值20
#define kLimit 25

//定位时加载地图的范围(单位：米)
#define kRadius 5000


#endif
