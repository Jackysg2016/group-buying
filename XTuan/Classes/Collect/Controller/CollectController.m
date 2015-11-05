//
//  CollectController.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "CollectController.h"
#import "CollectTool.h"

@interface CollectController ()

@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:_collectionView selector:@selector(reloadData) name:kCollectChangeNote object:nil];

}

-(NSArray *)totalDeals
{
    return [CollectTool sharedCollectTool].collectedDetails;
}

#pragma mark - 内存告警
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
