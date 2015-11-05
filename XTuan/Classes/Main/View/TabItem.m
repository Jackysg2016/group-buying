//
//  TabItem.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "TabItem.h"

@implementation TabItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置选中时（disable）的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar_item.png"] forState:UIControlStateDisabled];
    }
    return self;
}

-(void)setEnabled:(BOOL)enabled
{
    //控制顶部分割线要不要显示
    _divider.hidden = !enabled;
    
    [super setEnabled:enabled];
}

@end
