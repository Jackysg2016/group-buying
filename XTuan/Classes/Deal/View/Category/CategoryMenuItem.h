//
//  CategoryMenuItem.h
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealBottomMenuItem.h"

@class CategoryModel;
@interface CategoryMenuItem : DealBottomMenuItem
/**
 *  需要显示的分类信息
 */
@property(nonatomic, strong)CategoryModel *category;

@end
