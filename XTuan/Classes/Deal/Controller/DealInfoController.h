//
//  DealInfoController.h
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  团购简介

#import <UIKit/UIKit.h>

@class DealModel;
@interface DealInfoController : UIViewController

@property(nonatomic, strong)DealModel *deal;

-(instancetype)initWithDeal:(DealModel *)deal;

@end
