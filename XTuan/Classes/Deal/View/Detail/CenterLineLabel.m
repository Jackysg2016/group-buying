//
//  CenterLineLabel.m
//  XTuan
//
//  Created by dengwei on 15/8/18.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "CenterLineLabel.h"

@implementation CenterLineLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置颜色
    [self.textColor setStroke];
    
    //画线
    CGFloat y = rect.size.height * 0.4;
    CGContextMoveToPoint(context, 0, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width;
    CGContextAddLineToPoint(context, endX, y);
    
    //渲染
    CGContextStrokePath(context);
}

@end
