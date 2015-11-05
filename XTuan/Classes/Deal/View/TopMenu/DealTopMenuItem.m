//
//  DealTopMenuItem.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealTopMenuItem.h"
#import "UIImage+X.h"

#define kTitleScale 0.75

@implementation DealTopMenuItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置箭头
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //添加右边分割线
        UIImage *image = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc] initWithImage:image];
        divider.center = CGPointMake(kTopMenuItemWidth, kTopMenuItemHeight * 0.5);
        [self addSubview:divider];
        
        //选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuItemWidth, kTopMenuItemHeight);
    [super setFrame:frame];
}

#pragma mark 设置文字显示边框
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat w = contentRect.size.width * kTitleScale;
    return CGRectMake(0, 0, w, h);
}

#pragma mark 设置图片显示边框
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat x = contentRect.size.width * kTitleScale;
    CGFloat w = contentRect.size.width - x;
    return CGRectMake(x, 0, w, h);
}

@end
