//
//  Dock.m
//  XTuan
//
//  Created by dengwei on 15/8/13.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "Dock.h"
#import "MoreItem.h"
#import "LocationItem.h"
#import "TabItem.h"

@interface Dock ()
{
    TabItem *_selectedItem; //被选中的标签
}

@end

@implementation Dock

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //1.自动伸缩(高度＋右边间距)
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        //2.背景颜色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        
        //3.添加logo
        [self addLogo];
        
        //4.添加选项标签
        [self addTabs];
        
        //5.添加定位
        [self addLocation];
        
        //6.添加更多
        [self addMore];
        
    }
    return self;
}

#pragma mark 添加选项标签
-(void)addTabs
{
    //1.团购
    [self addOneTab:@"ic_deal.png" selected:@"ic_deal_hl.png" index:1];
    
    //2.地图
    [self addOneTab:@"ic_map.png" selected:@"ic_map_hl.png" index:2];
    
    //3.收藏
    [self addOneTab:@"ic_collect.png" selected:@"ic_collect_hl.png" index:3];
    
    //4.我的
    [self addOneTab:@"ic_mine.png" selected:@"ic_mine_hl.png" index:4];
    
    //5.添加标签底部分割线
    //添加底部分割线
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
    divider.frame = CGRectMake(0, kDockItemHeight * 5, kDockItemWidth, 2);
    
    [self addSubview:divider];
}

-(void)addOneTab:(NSString *)icon selected:(NSString *)selectedIcon index:(int)index
{
    TabItem *tab = [[TabItem alloc]init];
    [tab setIcon:icon selectedIcon:selectedIcon];
    tab.frame = CGRectMake(0, kDockItemHeight * index, 0, 0);
    [tab addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
    tab.tag = index - 1;
    [self addSubview:tab];
    
    if (index == 1) {
        [self tabClick:tab];
    }
}

#pragma mark 监听tab点击
-(void)tabClick:(TabItem *)tab
{
    //0.通知代理
    if ([_delegate respondsToSelector:@selector(dock:tabChangedFrom:to:)]) {
        [_delegate dock:self tabChangedFrom:(int)_selectedItem.tag to:(int)tab.tag];
    }
    
    //1.上次选中的恢复可选
    _selectedItem.enabled = YES;
    //2.当前选中的不可选
    tab.enabled = NO;
    //3.将当前的赋值给选中的
    _selectedItem = tab;
    
    
}

#pragma mark 添加定位
-(void)addLocation
{
    LocationItem *location = [[LocationItem alloc]init];
    CGFloat y = self.frame.size.height - kDockItemHeight * 2;
    //location.enabled = NO;
    location.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:location];
}

#pragma mark 添加更多
-(void)addMore
{
    MoreItem *more = [[MoreItem alloc] init];
    CGFloat y = self.frame.size.height - kDockItemHeight;
    more.frame = CGRectMake(0, y, 0, 0);
//    more.enabled = NO;
    [self addSubview:more];
    
}

#pragma mark 添加logo
-(void)addLogo
{
    UIImageView *logo = [[UIImageView alloc]init];
    logo.image = [UIImage imageNamed:@"ic_logo.png"];
    //设置尺寸
    CGFloat scale = 0.65;
    CGFloat logoW = logo.image.size.width * scale;
    CGFloat logoH = logo.image.size.height * scale;
    logo.bounds = CGRectMake(0, 0, logoW, logoH);
    //设置位置
    logo.center = CGPointMake(kDockItemWidth * 0.5, kDockItemHeight * 0.5);
    [self addSubview:logo];
}

#pragma mark 重写setFrame方法：内定自己的宽度
-(void)setFrame:(CGRect)frame
{
    frame.size.width = kDockItemWidth;
    [super setFrame:frame];
}

@end
