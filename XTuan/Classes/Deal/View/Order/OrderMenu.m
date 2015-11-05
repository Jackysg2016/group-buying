//
//  OrderMenu.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "OrderMenu.h"
#import "MetaDataTool.h"
#import "OrderMenuItem.h"

@implementation OrderMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //往scrollView中添加内容
        NSArray *orders = [MetaDataTool sharedMetaDataTool].totalOrders;
        
        int count = (int)orders.count;
        
        for (int i = 0; i < count; i++) {
            
            //创建区域item
            OrderMenuItem *item = [[OrderMenuItem alloc]init];
            item.order = orders[i];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemWidth, 0, 0, 0);
            [_scrollView addSubview:item];
            
            //默认选中第0个item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemWidth, 0);
        
    }
    return self;
}

@end
