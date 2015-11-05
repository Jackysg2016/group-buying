//
//  DockItem.h
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DockItem : UIButton
{
    UIImageView *_divider;
}

/**
 *  普通图片
 */
@property(nonatomic, copy)NSString *icon;

/**
 *  选中图片
 */
@property(nonatomic, copy)NSString *selectedIcon;

-(void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon;

@end
