//
//  DockItem.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  Dock上所有Item的父类

#import "DockItem.h"

@implementation DockItem

#pragma mark - 初始化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加顶部分割线
        UIImageView *divider = [[UIImageView alloc]init];
        divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        divider.frame = CGRectMake(0, 0, kDockItemWidth, 2);
        
        [self addSubview:divider];
        _divider = divider;
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDockItemWidth, kDockItemHeight);
    
    [super setFrame:frame];
}

#pragma mark - 重写按钮高亮状态（没有高亮状态）
-(void)setHighlighted:(BOOL)highlighted
{
    
}

#pragma mark - 设置按钮内部图片
-(void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    self.icon = icon;
    self.selectedIcon = selectedIcon;
}

-(void)setIcon:(NSString *)icon
{
    _icon = icon;
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

-(void)setSelectedIcon:(NSString *)selectedIcon
{
    _selectedIcon = selectedIcon;
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}



@end
