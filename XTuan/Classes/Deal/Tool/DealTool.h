//
//  DealTool.h
//  XTuan
//
//  Created by dengwei on 15/8/17.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Singleton.h"

@class DealModel;

//deals里面装的都是模型
typedef void (^DealsSuccessBlock)(NSArray *deals, int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

//deal里面装的都是模型
typedef void (^DealSuccessBlock)(DealModel *deal);
typedef void (^DealErrorBlock)(NSError *error);

@interface DealTool : NSObject

singleton_interface(DealTool)

#pragma mark 获得第page页的团购数据
-(void)dealsWithPage:(int)page success:(DealsSuccessBlock)success failure:(DealsErrorBlock)failure;

#pragma mark 获得指定的团购数据
-(void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success failure:(DealErrorBlock)failure;

#pragma mark 获得周边团购的信息
-(void)dealsWithPostion:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success failure:(DealsErrorBlock)failure;

@end
