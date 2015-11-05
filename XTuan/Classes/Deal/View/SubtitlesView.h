//
//  SubtitlesView.h
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubtitlesView;
@protocol  SubtitlesViewDelegate <NSObject>

@optional
-(void)subtitlesView:(SubtitlesView *)subtitlesView titleClick:(NSString *)title;
-(NSString *)subtitlesViewGetCurrentTitle:(SubtitlesView *)subtitlesView;

@end

@interface SubtitlesView : UIImageView

@property(nonatomic, copy)NSString *mainTitle; //主标题
@property(nonatomic, strong)NSArray *titles; //所有的子标题文字

@property(nonatomic, weak)id<SubtitlesViewDelegate> delegate;

//@property(nonatomic, copy)void (^setTitleBlock)(NSString *title);
//
//@property(nonatomic, copy)NSString *(^getTitleBlock)();

/**
 *  动画显示
 */
-(void)show;

/**
 *  动画隐藏
 */
-(void)hide;

@end
