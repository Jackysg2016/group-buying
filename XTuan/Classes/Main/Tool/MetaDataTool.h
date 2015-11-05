//
//  MetaDataTool.h
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  元数据管理类
//  1.城市数据
//  2.下属分区数据
//  3.分类数据

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class City;
@class OrderModel;
@interface MetaDataTool : NSObject

singleton_interface(MetaDataTool)

/**
 *  所有的城市组数据
 */
@property(nonatomic, strong, readonly)NSArray *totalCitySections;

/**
 *  所有的城市
 */
@property(nonatomic, strong, readonly)NSDictionary *totalCities;

/**
 *  所有的分类数据
 */
@property(nonatomic, strong, readonly)NSArray *totalCategories;

/**
 *  所有的排序数据
 */
@property(nonatomic, strong, readonly)NSArray *totalOrders;

/**
 *  根据名称返回order
 *
 *  @param name 排序名称
 *
 *  @return 排序
 */
-(OrderModel *)orderWithName:(NSString *)name;


/**
 *  根据类型名称返回对应的图标名
 *
 *  @param name 类型名称
 *
 *  @return 图标名
 */
-(NSString *)iconWithCategoryName:(NSString *)name;

/**
 *  当前选中城市
 */
@property(nonatomic, strong)City *currentCity;

/**
 *  当前选中类别
 */
@property(nonatomic, strong)NSString *currentCategory;

/**
 *  当前选中区域
 */
@property(nonatomic, strong)NSString *currentDistrict;

/**
 *  当前选中排序
 */
@property(nonatomic, strong)OrderModel *currentOrder;

@end
