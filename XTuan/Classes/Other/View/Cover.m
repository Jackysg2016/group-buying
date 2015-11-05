//
//  Cover.m
//  XTuan
//
//  Created by dengwei on 15/8/18.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "Cover.h"

#define kAlpha 0.6

@implementation Cover

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //背景色
        self.backgroundColor = [UIColor blackColor];
        //透明度
        self.alpha = kAlpha;
        //自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

-(void)reset
{
    self.alpha = kAlpha;
}

+(instancetype)cover
{
    return [[self alloc]init];
}

+(instancetype)coverWithTarget:(id)target action:(SEL)action
{
    Cover *cover = [self cover];
    
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:action]];
    
    return cover;
}

@end
