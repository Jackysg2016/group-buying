//
//  MetaDataTool.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  

#import "MetaDataTool.h"
#import "CitySection.h"
#import "NSObject+Value.h"
#import "City.h"
#import "CategoryModel.h"
#import "OrderModel.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface MetaDataTool ()
{
    NSMutableArray *_visitedCityNames; //存储曾经访问过城市的名称
    NSMutableDictionary *_totalCities; //存放所有的城市 key是城市名 vlaue是城市对象
    CitySection *_visitedSection; //最近访问的城市数组
}


@end

@implementation MetaDataTool

//单例模式
singleton_implementation(MetaDataTool)

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化项目中的所有元数据
        
        //初始化城市数据
        [self loadCityData];
        
        //初始化分类数据
        [self loadCategoryData];
        
        //初始化排序数据
        [self loadOrderData];
        
    }
    return self;
}

#pragma mark 初始化排序数据
-(void)loadOrderData
 {
     NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders.plist" ofType:nil]];
     NSMutableArray *temp = [NSMutableArray array];
     
     int count = (int)array.count;
     for (int i = 0; i < count; i++) {
         OrderModel *o = [[OrderModel alloc] init];
         o.name = array[i];
         o.index = i + 1;
         [temp addObject:o];
     }
     
     _totalOrders = temp;
 }

#pragma mark 初始化城市数据
-(void)loadCityData
{
    //存放所有的城市
    _totalCities = [NSMutableDictionary dictionary];
    //存放所有的城市组
    NSMutableArray *tempSections = [NSMutableArray array];
    
    //添加热门城市组
    CitySection *hotSections = [[CitySection alloc] init];
    hotSections.name = @"热门城市";
    //存放所有热门城市
    hotSections.cities = [NSMutableArray array];
    [tempSections addObject:hotSections];
    
    //添加A－Z组数据
    //加载plist数据
    NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    //遍历数组
    for (NSDictionary *azDict in azArray) {
        CitySection *section = [[CitySection alloc] init];
        [section setValues:azDict];
        [tempSections addObject:section];
        
        //遍历这组的所有城市
        for (City *city in section.cities) {
            if (city.hot) { //添加热门城市
                [hotSections.cities addObject:city];
            }
            
            [_totalCities setObject:city forKey:city.name];
        }
    }
    
    //从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    //添加最近访问城市组
    CitySection *visitedSection = [[CitySection alloc] init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    _visitedSection = visitedSection;
    
    
    for (NSString *name in _visitedCityNames) {
        City *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    if (_visitedCityNames.count) {
        [tempSections insertObject:visitedSection atIndex:0];
    }
    
    _totalCitySections = tempSections;
}

-(OrderModel *)orderWithName:(NSString *)name
{
    for (OrderModel *order in _totalOrders) {
        if ([name isEqualToString:order.name]) {
            return order;
        }
    }
    
    return nil;
}

#pragma mark 通过分类名称取得图标
-(NSString *)iconWithCategoryName:(NSString *)name
{
    for (CategoryModel *category in _totalCategories) {
        //分类名称保持一致
        if ([category.name isEqualToString:name]) {
            return category.icon;
        }
        
        //有这个子分类
        if ([category.subcategories containsObject:name]) {
            return category.icon;
        }
    }
    
    return nil;
}

#pragma mark 初始化分类数据
-(void)loadCategoryData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    //添加全部分类
    CategoryModel *all = [[CategoryModel alloc]init];
    all.name = kAllCategoryStr;
    all.icon = @"ic_filter_category_-1.png";
    [temp addObject:all];
    
    for (NSDictionary *dict in array) {
        CategoryModel *c = [[CategoryModel alloc] init];
        [c setValues:dict];
        
        [temp addObject:c];
    }
    
    _totalCategories = temp;
}

-(void)setCurrentCity:(City *)currentCity
{
    _currentCity = currentCity;
    
    //修改当前选中的区域
    _currentDistrict = kAllDistrictStr;
    
    //移除之前存在的相同的城市
    [_visitedCityNames removeObject:currentCity.name];
    
    //将新的城市名添加到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    //将新的城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    //发出通知(因为数据保存在model中，不用再传递值)
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    //肯定要添加“最近访问”这一组,没有这一组则添加
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSection = (NSMutableArray *)_totalCitySections;
        [allSection insertObject:_visitedSection atIndex:0];
    }
    
}

-(void)setCurrentCategory:(NSString *)currentCategory
{
    _currentCategory = currentCategory;
    //发出通知(因为数据保存在model中，不用再传递值)
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil];
}

-(void)setCurrentDistrict:(NSString *)currentDistrict
{
    _currentDistrict = currentDistrict;
    //发出通知(因为数据保存在model中，不用再传递值)
    [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil];
}

-(void)setCurrentOrder:(OrderModel *)currentOrder
{
    _currentOrder = currentOrder;
    //发出通知(因为数据保存在model中，不用再传递值)
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil];
}

@end
