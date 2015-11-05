//
//  InfoText.h
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "RoundRectView.h"

@interface InfoText : RoundRectView
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;

+(instancetype)infoText;


@end
