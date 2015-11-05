//
//  DealTopMenu.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealTopMenu.h"
#import "DealTopMenuItem.h"
#import "CategoryMenu.h"
#import "DistrictMenu.h"
#import "OrderMenu.h"
#import "MetaDataTool.h"
#import "OrderModel.h"

@interface DealTopMenu ()
{
    DealTopMenuItem *_selectedItem;
    
    CategoryMenu *_categoryMenu; //分类菜单
    DistrictMenu *_districtMenu; //区域菜单
    OrderMenu *_orderMenu; //排序菜单
    
    DealBottomMenu *_showingMenu;//正在显示的底部菜单
    
    DealTopMenuItem *_categoryItem;
    DealTopMenuItem *_districtItem;
    DealTopMenuItem *_orderItem;
}

@end

@implementation DealTopMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //全部分类
        _categoryItem = [self addMenuItem:kAllCategoryStr index:0];
        
        //全部商区
        _districtItem = [self addMenuItem:kAllDistrictStr index:1];
        
        //选择排序
        _orderItem = [self addMenuItem:@"默认排序" index:2];
        
        //监听通知
        kAddAllNotes(dataChanged)

    }
    return self;
}

-(void)dataChanged
{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    //1.分类按钮文字
    NSString *category = [MetaDataTool sharedMetaDataTool].currentCategory;
    if (category) {
        _categoryItem.title = category;
    }
    
    //2.商区按钮文字
    NSString *district = [MetaDataTool sharedMetaDataTool].currentDistrict;
    if (district) {
        _districtItem.title = district;
    }
    
    //3.排序按钮文字
    NSString *order = [MetaDataTool sharedMetaDataTool].currentOrder.name;
    if (order) {
        _orderItem.title = order;
    }
    
    //4.隐藏底部菜单
    [_showingMenu hideWithAnimation];
    _showingMenu = nil;
    
}

-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 添加一个菜单项
-(DealTopMenuItem *)addMenuItem:(NSString *)title index:(int)index
{
    DealTopMenuItem *item = [[DealTopMenuItem alloc] init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemWidth * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    return item;
}

#pragma mark 监听顶部item的点击
-(void)itemClick:(DealTopMenuItem *)item
{
    //没有选择城市，不允许点击顶部菜单
    if ([MetaDataTool sharedMetaDataTool].currentCity == nil) {
        return;
    }
    
    //控制选中状态
    _selectedItem.selected = NO;
    
    if (_selectedItem == item) {
        _selectedItem = nil;
        
        //隐藏底部菜单
        [self hideBottomMenu];
        
    }else{
        item.selected = YES;
        _selectedItem = item;
        
        //显示底部菜单
        [self showBottomMenu:item];
    }
}

#pragma mark 隐藏底部菜单
-(void)hideBottomMenu
{
    [_showingMenu hideWithAnimation];
    _showingMenu = nil;
}

#pragma mark 显示底部菜单
-(void)showBottomMenu:(DealTopMenuItem *)item
{
    BOOL animted = _showingMenu == nil;
    
    //移除当前正在显示的菜单
    [_showingMenu removeFromSuperview];
    
    //显示底部菜单
    if (item.tag == 0) { //分类
        if (_categoryMenu == nil) {
            _categoryMenu = [[CategoryMenu alloc]init];
            
        }

        _showingMenu = _categoryMenu;
    }else if (item.tag == 1) { //区域
        if (_districtMenu == nil) {
            _districtMenu = [[DistrictMenu alloc]init];
            
        }

        _showingMenu = _districtMenu;
    }else{ //排序
        if (_orderMenu == nil) {
            _orderMenu = [[OrderMenu alloc]init];
            
        }
        
        _showingMenu = _orderMenu;
    }
    
    _showingMenu.frame = _contentView.bounds;
    
    __unsafe_unretained DealTopMenu *menu = self; //解决block循环调用问题
    _showingMenu.hideBlock = ^{
        //1.取消选中当前的item
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        
        //2.清空正在显示的菜单
        menu->_showingMenu = nil;
    };
    
    [_contentView addSubview:_showingMenu];
    //执行菜单出现的动画
    if (animted) {
        [_showingMenu showWithAnimation];
    }
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuItemWidth * 3, kTopMenuItemHeight);
    [super setFrame:frame];
}

@end
