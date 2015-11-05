//
//  CategoryMenu.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "CategoryMenu.h"
#import "MetaDataTool.h"
#import "CategoryMenuItem.h"
#import "CategoryModel.h"
#import "SubtitlesView.h"

@interface CategoryMenu ()
{
    //SubtitlesView *_subtitlesView; //子标题view
}

@end

@implementation CategoryMenu


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *categories = [MetaDataTool sharedMetaDataTool].totalCategories;
        
        //往scrollView中添加内容
        int count = (int)categories.count;
        for (int i = 0; i < count; i++) {
            //创建item
            CategoryMenuItem *item = [[CategoryMenuItem alloc]init];
            item.category = categories[i];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemWidth, 0, 0, 0);
            [_scrollView addSubview:item];
            
            //默认选中第0个item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemWidth, 0);
        
    }
    return self;
}

//-(void)settingSubtitlesView
//{
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [MetaDataTool sharedMetaDataTool].currentCategory = title;
//    };
//    
//    _subtitlesView.getTitleBlock = ^{
//        return [MetaDataTool sharedMetaDataTool].currentCategory;
//    };
//}

-(void)subtitlesView:(SubtitlesView *)subtitlesView titleClick:(NSString *)title
{
    [MetaDataTool sharedMetaDataTool].currentCategory = title;
}

-(NSString *)subtitlesViewGetCurrentTitle:(SubtitlesView *)subtitlesView
{
    return [MetaDataTool sharedMetaDataTool].currentCategory;
}

@end
