//
//  DealBaseListController.h
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "BaseShowDetailController.h"

@interface DealBaseListController : BaseShowDetailController
{
    UICollectionView *_collectionView;
}

-(NSArray *)totalDeals;//所有的团购数组

@end
