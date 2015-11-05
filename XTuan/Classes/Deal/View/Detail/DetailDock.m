//
//  DetailDock.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DetailDock.h"
#import "DetailDockItem.h"

@interface DetailDock ()
{
    UIButton *_selectedBtn;
}

@end

@implementation DetailDock

+(instancetype)detailDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailDock" owner:nil options:nil][0];
}

-(void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

-(void)awakeFromNib
{
    [self btnClick:_infoBtn];
}

- (IBAction)btnClick:(UIButton *)sender {
    //通知代理
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)]) {
        [_delegate detailDock:self btnClickFrom:_selectedBtn.tag to:sender.tag];
    }
    //控制按钮状态
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    //添加被点击的按钮在最上面
    if (sender == _infoBtn) { //点击了第1个按钮
        [self insertSubview:_merchantBtn atIndex:0];
    }else if (sender == _merchantBtn){ //点击了第3个按钮
        [self insertSubview:_infoBtn atIndex:0];
    }
        
    [self bringSubviewToFront:sender];
}
@end
