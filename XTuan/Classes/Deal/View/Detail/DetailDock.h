//
//  DetailDock.h
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailDockItem, DetailDock;

//协议
@protocol DetailDockDelegate <NSObject>

@optional
-(void)detailDock:(DetailDock *)detailDock btnClickFrom:(int)from to:(int)to;

@end

@interface DetailDock : UIView
- (IBAction)btnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet DetailDockItem *infoBtn;
@property (weak, nonatomic) IBOutlet DetailDockItem *merchantBtn;

@property (weak, nonatomic) id<DetailDockDelegate> delegate;

+(instancetype)detailDock;

@end

