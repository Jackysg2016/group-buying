//
//  DealBottomMenu.h
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  底部菜单(父类)

#import <UIKit/UIKit.h>

@class SubtitlesView,DealBottomMenuItem;

@protocol SubtitlesViewDelegate;

@interface DealBottomMenu : UIView <SubtitlesViewDelegate>
{
    UIScrollView *_scrollView;
    SubtitlesView *_subtitlesView;
    DealBottomMenuItem *_selectedItem;
}

@property(nonatomic, copy)void (^hideBlock)();

//-(void)settingSubtitlesView;

/**
 *  动画显示
 */
-(void)showWithAnimation;

/**
 *  动画隐藏
 */
-(void)hideWithAnimation;

@end
