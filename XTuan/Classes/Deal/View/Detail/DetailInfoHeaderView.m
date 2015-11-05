//
//  DetailInfoHeaderView.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DetailInfoHeaderView.h"
#import "DealModel.h"
#import "ImageTool.h"
#import "NSDate+X.h"
#import "RestrictionModel.h"

#define kOffsetHeight 20

@implementation DetailInfoHeaderView

+(instancetype)detailInfoHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailInfoHeaderView" owner:nil options:nil][0];
}

-(void)setDeal:(DealModel *)deal
{
    _deal = deal;
    
    if (deal.restrictions) { //有约束（完整数据）
        //1.设置是否支持退款
        _anyTimeBack.enabled = deal.restrictions.is_refundable;
        _expireBack.enabled = _anyTimeBack.enabled;
        
    }else{ //不完整数据
        //2.下载图片
        [ImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
        
        //3.设置剩余时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        //2015-08-11
        NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
        //2015-08-12 00:00:00
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        //2015-08-11 10:50:00
        NSDate *now = [NSDate date];
        
        //NSDateComponents *comps = [NSDate compareForm:now to:dealline];
        NSDateComponents *comps = [now compare:dealline];
        
        NSString *timeStr = [NSString stringWithFormat:@"%ld天 %ld小时 %ld分钟", comps.day, comps.hour, comps.minute];
        [_time setTitle:timeStr forState:UIControlStateNormal];
    }
    
    //4.购买人数
    NSString *pc = [NSString stringWithFormat:@"%d 人已购买", deal.purchase_count];
    [_purchaseCount setTitle:pc forState:UIControlStateNormal];
    
    //5.设置团购描述
    _desc.text = deal.desc;
    //描述的高度
    CGFloat descHeight = [deal.desc sizeWithFont:_desc.font constrainedToSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT) lineBreakMode:_desc.lineBreakMode].height + kOffsetHeight;
    CGRect descFrame = _desc.frame;
    CGFloat descDeltaHeight = descHeight - descFrame.size.height;
    descFrame.size.height = descHeight;
    _desc.frame = descFrame;
    
    //6.设置整体的高度
    CGRect selfFrame = self.frame;
    selfFrame.size.height += descDeltaHeight;
    self.frame = selfFrame;
    
    
    
}

@end
