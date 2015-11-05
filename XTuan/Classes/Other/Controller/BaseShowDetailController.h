//
//  BaseShowDetailController.h
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  当需要展示团购详情的时候，就继承这个控制器

#import <UIKit/UIKit.h>

@class DealModel;
@interface BaseShowDetailController : UIViewController

-(void)showDetail:(DealModel *)deal;
-(void)hideDetail;

@end
