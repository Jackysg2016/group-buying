//
//  DistrictMenu.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DistrictMenu.h"
#import "DistrictMenuItem.h"
#import "MetaDataTool.h"
#import "City.h"
#import "District.h"
#import "SubtitlesView.h"

@interface DistrictMenu ()
{
    NSMutableArray *_menuItems;//保存所有item，用于计数，因为scrollview默认有两个子控件，不能直接用subviews.count判断数量
}

@end

@implementation DistrictMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.往scrollView中添加内容
        
        _menuItems = [NSMutableArray array];
        
        [self cityChanged];
        
//        //获取当前选中的城市
//        City *city = [MetaDataTool sharedMetaDataTool].currentCity;
//        
//        //当前城市的全部商区
//        NSMutableArray *districts = [NSMutableArray array];
//        
//        //添加全部商区
//        District *all = [[District alloc]init];
//        all.name = kAllDistrictStr;
//        [districts addObject:all];
//        //添加其他商区
//        [districts addObjectsFromArray:city.districts];
//        
//        //遍历所有的商区
//        int count = (int)districts.count;
//        for (int i = 0; i < count; i++) {            
//            //创建区域item
//            DistrictMenuItem *item = [[DistrictMenuItem alloc]init];
//            item.district = districts[i];
//            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
//            item.frame = CGRectMake(i * kBottomMenuItemWidth, 0, 0, 0);
//            [_scrollView addSubview:item];
//            
//            //默认选中第0个item
//            if (i == 0) {
//                item.selected = YES;
//                _selectedItem = item;
//            }
//        }
//        
//        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemWidth, 0);
        
        //监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged) name:kCityChangeNote object:nil];
        
    }
    return self;
}

#pragma mark 监听城市改变
-(void)cityChanged
{
    //获取当前选中的城市
    City *city = [MetaDataTool sharedMetaDataTool].currentCity;
    
    //当前城市的全部商区
    NSMutableArray *districts = [NSMutableArray array];
    
    //添加全部商区
    District *all = [[District alloc]init];
    all.name = kAllDistrictStr;
    [districts addObject:all];
    //添加其他商区
    [districts addObjectsFromArray:city.districts];
    
    //遍历所有的商区
    int count = (int)districts.count;
    for (int i = 0; i < count; i++) {
        DistrictMenuItem *item = nil;
        if (i >= _menuItems.count) { //不够
            //创建区域item
            item = [[DistrictMenuItem alloc]init];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_menuItems addObject:item]; //计数
            [_scrollView addSubview:item]; //显示
        }else{
            item = _menuItems[i];
        }
        
        item.hidden = NO;
        item.district = districts[i];
        item.frame = CGRectMake(i * kBottomMenuItemWidth, 0, 0, 0);
        
        //默认选中第0个item
        if (i == 0) {
            item.selected = YES;
            _selectedItem = item;
        }else{
            item.selected = NO;
        }
    }
    
    //隐藏多余的item,scrollview默认有两个子控件
    for (int i = count; i < _menuItems.count; i++) {
        DistrictMenuItem *item = _scrollView.subviews[i];
        item.hidden = YES;
    }
    
    //设置scrollview的内容尺寸
    _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemWidth, 0);
    
    //隐藏子标题
    [_subtitlesView hide];
    
}

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(void)settingSubtitlesView
//{
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [MetaDataTool sharedMetaDataTool].currentDistrict = title;
//    };
//    
//    _subtitlesView.getTitleBlock = ^{
//        return [MetaDataTool sharedMetaDataTool].currentDistrict;
//    };
//}

-(void)subtitlesView:(SubtitlesView *)subtitlesView titleClick:(NSString *)title
{
    [MetaDataTool sharedMetaDataTool].currentDistrict = title;
}

-(NSString *)subtitlesViewGetCurrentTitle:(SubtitlesView *)subtitlesView
{
    return [MetaDataTool sharedMetaDataTool].currentDistrict;
}

@end
