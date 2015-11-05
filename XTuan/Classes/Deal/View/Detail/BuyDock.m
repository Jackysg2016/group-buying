//
//  BuyDock.m
//  XTuan
//
//  Created by dengwei on 15/8/18.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "BuyDock.h"
#import "DealModel.h"
#import "CenterLineLabel.h"
#import "UIImage+X.h"

@implementation BuyDock

+(instancetype)buyDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"BuyDock" owner:nil options:nil][0];
}

-(void)setDeal:(DealModel *)deal
{
    _deal = deal;
    
    _listPrice.text = [NSString stringWithFormat:@" %@ 元 ", deal.list_price_text];
    _currentPrice.text = deal.current_price_text;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}

- (IBAction)buyBtn {
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kToBuyDealNote object:nil];
//    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
//    NSString *url = [NSString stringWithFormat:@"http://o.p.dianping.com/buy/d%@", ID];
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
