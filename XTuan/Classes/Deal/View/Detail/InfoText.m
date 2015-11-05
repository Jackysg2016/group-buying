//
//  InfoText.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "InfoText.h"

#define kOffsetHeight 20

@implementation InfoText

+(instancetype)infoText
{
    return [[NSBundle mainBundle] loadNibNamed:@"InfoText" owner:nil options:nil][0];
}

-(void)setIcon:(NSString *)icon
{
    _icon = icon;
    
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    
    [_titleView setTitle:title forState:UIControlStateNormal];
}

-(void)setContent:(NSString *)content
{
    _content = content;
    
    //设置label文字
    _contentView.text = content;
    
    //计算文字的高度
    CGFloat textHeight = [content sizeWithFont:_contentView.font constrainedToSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) lineBreakMode:_contentView.lineBreakMode].height + kOffsetHeight;
    
    CGRect contentFrame = _contentView.frame;
    CGFloat contentDeltaHeight = textHeight - contentFrame.size.height;
    contentFrame.size.height = textHeight;
    _contentView.frame = contentFrame;
    
    //调整整体高度
    CGRect selfFrame = self.frame;
    selfFrame.size.height += contentDeltaHeight;
    self.frame = selfFrame;
    
}


@end
