//
//  MoreItem.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "MoreItem.h"
#import "MoreController.h"
#import "XNavigationController.h"

@implementation MoreItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        //2.设置图片
        [self setIcon:@"ic_more.png" selectedIcon:@"ic_more_hl.png"];
        
        //3.监听点击
        [self addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void)moreClick
{
    self.enabled = NO;
    
    //弹出更多控制器
    MoreController *more = [[MoreController alloc] init];
    more.moreItem = self;
    XNavigationController *moreNav = [[XNavigationController alloc] initWithRootViewController:more];
    
    //控制弹出的样式
    moreNav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    //设置弹出效果
    moreNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.window.rootViewController presentViewController:moreNav animated:YES completion:nil];
}

@end
