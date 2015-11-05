//
//  SubtitlesView.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "SubtitlesView.h"
#import "UIImage+X.h"
#import "MetaDataTool.h"

/**
 *  item文字尺寸
 */
#define kTitleWidth 110
#define kTitleHeight 40


@interface SubtitlesView ()
{
    UIButton *_selectedBtn;
}

@end

@implementation SubtitlesView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
        
        //剪掉超出父控件范围内的子控件
        self.clipsToBounds = YES;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setTitles:(NSArray *)titles
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kAllStr];
    [array addObjectsFromArray:titles];
    
    _titles = array;
    
    int count = (int)_titles.count;
    //设置按钮的文字
    for (int i = 0; i < count; i++) {
        //取出i位置对应的按钮
        UIButton *btn = nil;
        if (i >= self.subviews.count) { //不够
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //设置按钮文字字体大小
            btn.titleLabel.font = [UIFont systemFontOfSize:14.5];
            [self addSubview:btn];
        }else{
            btn = self.subviews[i];
        }
        
        btn.hidden = NO;
        
        //按钮文字
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        
        //根据按钮文字判断是否选中
//        if (_getTitleBlock) {
//            NSString *current = _getTitleBlock();
//            btn.selected = [titles[i] isEqualToString:current];
//        }else{
//            btn.selected = NO;
//        }
        if ([_delegate respondsToSelector:@selector(subtitlesViewGetCurrentTitle:)]) {
            NSString *current = [_delegate subtitlesViewGetCurrentTitle:self];
            //选中主标题,选中第0个按钮（“全部”按钮）
            if ([current isEqualToString:_mainTitle] && i == 0) {
                btn.selected = YES;
                _selectedBtn = btn;
            }else{
            
                btn.selected = [_titles[i] isEqualToString:current];
                if (btn.selected) {
                    _selectedBtn = btn;
                }
            }
        }else{
            btn.selected = NO;
        }

    }
    
    //隐藏多余的按钮
    for (int i = count; i < self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
    
    [self layoutSubviews];
}

#pragma mark 监听小标题（按钮）点击
-(void)titleClick:(UIButton *)btn
{
    //控制按钮状态
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    
    
    //设置当前选中的分类文字
//    if (_setTitleBlock) {
//        _setTitleBlock([btn titleForState:UIControlStateNormal]);
//    }
    if ([_delegate respondsToSelector:@selector(subtitlesView:titleClick:)]) {
        
        NSString *title = [btn titleForState:UIControlStateNormal];
        
        if ([title isEqualToString:kAllStr]) { //将“全部”改成对应的大标题
            title = _mainTitle;
        }
        
        [_delegate subtitlesView:self titleClick:title];
    }
    
    //XLog(@"click %@ %@",[MetaDataTool sharedMetaDataTool].currentCategory, [MetaDataTool sharedMetaDataTool].currentDistrict);
}

#pragma mark 控件本身宽高改变时调用
-(void)layoutSubviews
{
    //一定要调用super
    [super layoutSubviews];
    
    int clolumns = self.frame.size.width / kTitleWidth;
    
    for (int i = 0; i < _titles.count; i++) {
        UIButton *btn = self.subviews[i];
        //设置位置
        CGFloat x = i % clolumns * kTitleWidth;
        CGFloat y = i / clolumns * kTitleHeight;
        btn.frame = CGRectMake(x, y, kTitleWidth, kTitleHeight);
    }
    
    int rows = (_titles.count + clolumns - 1) / clolumns;
    CGRect frame = self.frame;
    frame.size.height = rows * kTitleHeight + kNavigationBarHeight;
    self.frame = frame;
    
}

#pragma mark 通过动画显示
-(void)show
{
    [self layoutSubviews];
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{

        self.transform = CGAffineTransformIdentity;

        self.alpha = 1.0;
    }];
    
}

#pragma mark 通过动画隐藏
-(void)hide
{
    [UIView animateWithDuration:kDefaultAnimationDuration animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        self.transform = CGAffineTransformIdentity;        
        self.alpha = 1;
    }];
}

@end
