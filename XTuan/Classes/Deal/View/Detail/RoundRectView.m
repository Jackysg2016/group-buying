//
//  RoundRectView.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "RoundRectView.h"
#import "UIImage+X.h"

@implementation RoundRectView

-(void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

@end
