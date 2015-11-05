//
//  CollectTool.h
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  处理收藏业务

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class DealModel;
@interface CollectTool : NSObject

singleton_interface(CollectTool)

/**
 *  获得所有的收藏数据
 *
 */
@property (nonatomic, strong, readonly)NSArray *collectedDetails;

/**
 *  处理团购是否收藏
 *
 *  @param deal 需要判断的团购模型
 */
-(void)handleDeal:(DealModel *)deal;

/**
 *  收藏数据
 *
 *  @param deal 需要收藏的数据
 */
-(void)collectDeal:(DealModel *)deal;

/**
 *  取消收藏
 *
 *  @param deal 需要取消的收藏
 */
-(void)uncollectDeal:(DealModel *)deal;

@end
