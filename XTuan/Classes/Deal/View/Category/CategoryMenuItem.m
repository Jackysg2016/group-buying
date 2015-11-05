//
//  CategoryMenuItem.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "CategoryMenuItem.h"
#import "CategoryModel.h"

#define kTitleRatio 0.5

@implementation CategoryMenuItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //图片属性
        self.imageView.contentMode = UIViewContentModeCenter;

    }
    return self;
}

#pragma mark 设置按钮标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}

#pragma mark 设置按钮图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kTitleRatio));
}

-(void)setCategory:(CategoryModel *)category
{
    _category = category;
    
    //图标
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    
    //标题
    [self setTitle:category.name forState:UIControlStateNormal];
}

-(NSArray *)titles
{
    return _category.subcategories;
}

@end
