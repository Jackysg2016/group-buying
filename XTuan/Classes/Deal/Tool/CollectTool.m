//
//  CollectTool.m
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "CollectTool.h"
#import "DealModel.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collects.data"]


@interface CollectTool ()
{
    NSMutableArray *_collectedDetails;
}

@end


@implementation CollectTool

singleton_implementation(CollectTool)

-(instancetype)init
{
    if (self = [super init]) {
        //加载沙盒中的收藏数据
        _collectedDetails = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        //第一次没有收藏数据
        if (_collectedDetails == nil) {
            _collectedDetails = [NSMutableArray array];
        }
        
    }
    return self;
}

-(void)collectDeal:(DealModel *)deal
{
    deal.collected = YES;
    [_collectedDetails insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDetails toFile:kFilePath];
}

-(void)uncollectDeal:(DealModel *)deal
{
    deal.collected = NO;
    [_collectedDetails removeObject:deal];
    
    [NSKeyedArchiver archiveRootObject:_collectedDetails toFile:kFilePath];
}

-(void)handleDeal:(DealModel *)deal
{
    deal.collected = [_collectedDetails containsObject:deal];
}

@end
