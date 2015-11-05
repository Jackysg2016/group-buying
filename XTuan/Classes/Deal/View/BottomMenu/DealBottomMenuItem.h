//
//  DealBottomMenuItem.h
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  底部菜单项父类

#import <UIKit/UIKit.h>

@interface DealBottomMenuItem : UIButton

/**
 *  专门交给子类实现
 *
 *  @return 子标题需要展示的子分类数据
 */
-(NSArray *)titles;

@end
