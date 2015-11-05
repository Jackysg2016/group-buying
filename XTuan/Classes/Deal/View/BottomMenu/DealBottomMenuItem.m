//
//  DealBottomMenuItem.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealBottomMenuItem.h"
#import "UIImage+X.h"

@implementation DealBottomMenuItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //右边分割线
        UIImage *image = [UIImage imageNamed:@"separator_filter_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:image];
        divider.bounds = CGRectMake(0, 0, 2, kBottomMenuItemHeight * 0.7);
        divider.center = CGPointMake(kBottomMenuItemWidth, kBottomMenuItemHeight * 0.5);
        [self addSubview:divider];
        
        //文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置被选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"bg_filter_toggle_hl.png"] forState:UIControlStateSelected];
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kBottomMenuItemWidth, kBottomMenuItemHeight);
    [super setFrame:frame];
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

-(NSArray *)titles
{
    return nil;
}

@end
