//
//  DealCell.h
//  XTuan
//
//  Created by dengwei on 15/8/16.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealModel;
@interface DealCell : UICollectionViewCell

// 描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *price;
// 购买人数
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
// 标签
@property (weak, nonatomic) IBOutlet UIImageView *badge;

@property (strong, nonatomic) DealModel *deal;

@end
