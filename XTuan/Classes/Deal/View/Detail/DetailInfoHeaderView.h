//
//  DetailInfoHeaderView.h
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "RoundRectView.h"

@class DealModel;
@interface DetailInfoHeaderView : RoundRectView

//图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
//描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
//随时退款
@property (weak, nonatomic) IBOutlet UIButton *anyTimeBack;
//过期退款
@property (weak, nonatomic) IBOutlet UIButton *expireBack;
//时间
@property (weak, nonatomic) IBOutlet UIButton *time;
//购买人数
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

@property(strong, nonatomic)DealModel *deal;

+(instancetype)detailInfoHeaderView;
@end
