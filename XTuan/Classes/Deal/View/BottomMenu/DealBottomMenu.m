//
//  DealBottomMenu.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealBottomMenu.h"
#import "SubtitlesView.h"
#import "DealBottomMenuItem.h"
#import "MetaDataTool.h"

#import "DistrictMenuItem.h"
#import "CategoryMenuItem.h"
#import "OrderMenuItem.h"
#import "Cover.h"

@interface DealBottomMenu ()
{
    Cover *_cover;
    UIView *_contentView;
}

@end

@implementation DealBottomMenu

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        //添加蒙板
        _cover = [Cover coverWithTarget:self action:@selector(hideWithAnimation)];
        _cover.frame = self.bounds;
        //[_cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWithAnimation)]];
        [self addSubview:_cover];
        
        //contentView
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, kBottomMenuY, self.frame.size.width, kBottomMenuItemHeight);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        //添加UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemHeight);
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
        
    }
    return self;
}

-(void)itemClick:(DealBottomMenuItem *)item
{
    //控制item状态
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    //判断有无子类别
    if (item.titles.count) { //显示所有子标题
        [self showSubtitlesView:item];
        
    }else{ //隐藏所有子标题
        [self hideSubtitlesView:item];
    }
}

#pragma mark 隐藏子标题
-(void)hideSubtitlesView:(DealBottomMenuItem *)item
{
    //动画隐藏子标题
    [_subtitlesView hide];
    
    //调整内容view的高度
    CGRect f = _contentView.frame;
    f.size.height = kBottomMenuItemHeight; //变成scrollView的高度
    _contentView.frame = f;
    
    //设置数据
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[CategoryMenuItem class]]) {
        [MetaDataTool sharedMetaDataTool].currentCategory = title;
    }else if([item isKindOfClass:[DistrictMenuItem class]]){
        [MetaDataTool sharedMetaDataTool].currentDistrict = title;
    }else{
        [MetaDataTool sharedMetaDataTool].currentOrder = [[MetaDataTool sharedMetaDataTool] orderWithName:title];
    }
    
}

#pragma mark 显示子标题
-(void)showSubtitlesView:(DealBottomMenuItem *)item
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kDefaultAnimationDuration];
    
    if (_subtitlesView == nil) {
        _subtitlesView = [[SubtitlesView alloc]init];
        _subtitlesView.delegate = self;
        
        //[self settingSubtitlesView];
    }
    
    //设置子标题的frame
    _subtitlesView.frame = CGRectMake(0, kBottomMenuItemHeight, self.frame.size.width, _subtitlesView.frame.size.height);
    
    //设置主标题的内容
    _subtitlesView.mainTitle = [item titleForState:UIControlStateNormal];
    
    //设置子标题需要显示的内容
    _subtitlesView.titles = item.titles;
    
    if (_subtitlesView.superview == nil) { //没有父控件，采用动画方式出来
        [_subtitlesView show];
    }
    
    //添加子标题到内容view，scrollview底部
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    
    //调整整个内容view的高度
    CGRect f = _contentView.frame;
    //f.size.height = kBottomMenuItemHeight + _subtitlesView.frame.size.height;
    f.size.height = CGRectGetMaxY(_subtitlesView.frame);
    _contentView.frame = f;
    
    [UIView commitAnimations];
}

#pragma mark 通过动画显示
-(void)showWithAnimation
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -kBottomMenuItemHeight);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        //1._contentView从上面往下显示出来
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        
        //2.遮盖渐渐显示(0->0.4)
        [_cover reset];
    }];
    
}

#pragma mark 通过动画隐藏
-(void)hideWithAnimation
{
    if (_hideBlock) {
        _hideBlock();
    }
    
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        //1._contentView从下面往上隐藏
        _contentView.transform = CGAffineTransformMakeTranslation(0, -kBottomMenuItemHeight);
        _contentView.alpha = 0;
        
        //2.遮盖渐渐隐藏(0.4->0)
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        //恢复属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        [_cover reset];
        
    }];
}

@end
