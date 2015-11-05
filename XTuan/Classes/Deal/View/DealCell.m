//
//  DealCell.m
//  XTuan
//
//  Created by dengwei on 15/8/16.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealCell.h"
#import "DealModel.h"
#import "ImageTool.h"

@implementation DealCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setDeal:(DealModel *)deal
{
    _deal = deal;
    
    // 1.设置描述
    _desc.text = deal.desc;
    
    // 2.下载图片
    [ImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    
    // 3.购买人数
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d", deal.purchase_count] forState:UIControlStateNormal];
    
    // 4.价格
    _price.text = deal.current_price_text;
    
    // 5.标签
    //获得当前时间字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate:[NSDate date]];
    //比较当前时间
    if([deal.publish_date isEqualToString:now]) //"今日新单"标签显示
    {
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_new.png"];
    }else if ([deal.purchase_deadline isEqualToString:now]){ //"即将过期"标签显示
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_soonOver.png"];
    }else if ([deal.purchase_deadline compare:now] == NSOrderedAscending){ //"已结束"标签显示
        _badge.hidden = NO;
        _badge.image = [UIImage imageNamed:@"ic_deal_over.png"];
    }else{
        _badge.hidden = YES;
    }
}

@end
