//
//  BuyDock.h
//  XTuan
//
//  Created by dengwei on 15/8/18.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealModel,CenterLineLabel;
@interface BuyDock : UIView
@property (weak, nonatomic) IBOutlet CenterLineLabel *listPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
- (IBAction)buyBtn;

@property (strong, nonatomic)DealModel *deal;

+(instancetype)buyDock;

@end
