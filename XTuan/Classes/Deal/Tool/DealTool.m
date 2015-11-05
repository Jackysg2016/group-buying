//
//  DealTool.m
//  XTuan
//
//  Created by dengwei on 15/8/17.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealTool.h"
#import "DPAPI.h"
#import "MetaDataTool.h"
#import "City.h"
#import "OrderModel.h"
#import "DealModel.h"
#import "NSObject+Value.h"
#import "LocationTool.h"

typedef void (^RequestBlock)(id result, NSError *err);

@interface DealTool ()<DPRequestDelegate>
{
    NSMutableDictionary *_blocks;
}

@end
@implementation DealTool

singleton_implementation(DealTool)

-(instancetype)init
{
    self = [super init];
    if (self) {
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 获取大批团购
-(void)getDealsWithParams:(NSDictionary *)params success:(DealsSuccessBlock)success failure:(DealsErrorBlock)failure
{
    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *err) {
        if (err) { //请求失败
            if (failure) { //failure block
                failure(err);
            }
            
        }else if(success){ //请求成功
            NSArray *array = result[@"deals"];
            
            NSMutableArray *deals = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                DealModel *deal = [[DealModel alloc] init];
                [deal setValues:dict];
                [deals addObject:deal];
            }
            
            success(deals, [result[@"total_count"] intValue]);
        }
    }];
}

#pragma mark 获得指定的团购数据
-(void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success failure:(DealErrorBlock)failure
{
    [self requestWithURL:@"v1/deal/get_single_deal" params:
        @{@"deal_id":ID}
       block:^(id result, NSError *err) {
           NSArray *deals = result[@"deals"];
         if (deals.count) { //成功
             if (success) {
                 DealModel *deal = [[DealModel alloc]init];
                 [deal setValues:result[@"deals"][0]];
                 success(deal);
             }
         }else{
             if (err) {
                 failure(err);
             }
         }
       }];
}

#pragma mark 获得第page页的团购数据
-(void)dealsWithPage:(int)page success:(DealsSuccessBlock)success failure:(DealsErrorBlock)failure
{
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(kLimit) forKey:@"limit"];
    //1.添加城市参数
    NSString *city = [MetaDataTool sharedMetaDataTool].currentCity.name;
    [params setObject:city forKey:@"city"];
    
    //2.添加分类参数
    NSString *category = [MetaDataTool sharedMetaDataTool].currentCategory;
    if (category && ![category isEqualToString:kAllCategoryStr]) {
        [params setObject:category forKey:@"category"];
    }
    
    //3.添加区域参数
    NSString *district = [MetaDataTool sharedMetaDataTool].currentDistrict;
    if (district && ![district isEqualToString:kAllDistrictStr]) {
        [params setObject:district forKey:@"region"];
    }
    
    //4.添加排序参数
    OrderModel *order = [MetaDataTool sharedMetaDataTool].currentOrder;
    if (order) {
        if (order.index == 7) { //按距离最近排序
            City *city = [LocationTool sharedLocationTool].locationCity;
            XLog(@"city %@", city);
            if (city) {
                [params setObject:@(order.index) forKey:@"sort"];
                //增加经纬度参数
                [params setObject:@(city.position.latitude) forKey:@"latitude"];
                [params setObject:@(city.position.longitude) forKey:@"longitude"];
            }
        }else{ //按照其他方式排序
            [params setObject:@(order.index) forKey:@"sort"];
        }
        
    }
    
    //5.添加页码参数
    [params setObject:@(page) forKey:@"page"];
    
    //5.发送请求
//    [self requestWithURL:@"v1/deal/find_deals" params:params block:^(id result, NSError *err) {
//        if (err) { //请求失败
//            if (failure) { //failure block
//                failure(err);
//            }
//            
//        }else if(success){ //请求成功
//            NSArray *array = result[@"deals"];
//            
//            NSMutableArray *deals = [NSMutableArray array];
//            for (NSDictionary *dict in array) {
//                DealModel *deal = [[DealModel alloc] init];
//                [deal setValues:dict];
//                [deals addObject:deal];
//            }
//            
//            success(deals, [result[@"total_count"] intValue]);
//        }
//    }];
    [self getDealsWithParams:params success:success failure:failure];

}

#pragma mark 获得周边团购的信息
-(void)dealsWithPostion:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success failure:(DealsErrorBlock)failure
{
    City *city = [LocationTool sharedLocationTool].locationCity;
    if (city == nil) {
        return;
    }
    
    [self getDealsWithParams:
    @{
       @"city":city.name,
       @"latitude":@(pos.latitude),
       @"longitude":@(pos.longitude),
       @"radius":@(kRadius)
    } success:success failure:failure];
}

#pragma mark 封装大众点评任何请求
-(void)requestWithURL:(NSString *)url params:(NSDictionary *)params block:(RequestBlock)block
{
    DPAPI *api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    //一次请求对应一个block
    [_blocks setObject:block forKey:request.description];
}

#pragma mark 大众点评的请求方法代理(请求成功)
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(result, nil);
    }
}

#pragma mark 大众点评的请求方法代理(请求失败)
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    RequestBlock block = _blocks[request.description];
    if (block) {
        block(nil, error);
    }
}

@end
