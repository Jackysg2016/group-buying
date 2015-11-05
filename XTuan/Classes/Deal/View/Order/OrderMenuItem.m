//
//  OrderMenuItem.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "OrderMenuItem.h"
#import "OrderModel.h"

@implementation OrderMenuItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setOrder:(OrderModel *)order
{
    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}


@end
