//
//  DealPosAnnotationModel.m
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealPosAnnotationModel.h"
#import "MetaDataTool.h"
#import "DealModel.h"

@implementation DealPosAnnotationModel

-(void)setDeal:(DealModel *)deal
{
    _deal = deal;
    
    for (NSString *c in deal.categories) {
        NSString *icon = [[MetaDataTool sharedMetaDataTool] iconWithCategoryName:c];
        
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            break;
        }
    }
}

@end
