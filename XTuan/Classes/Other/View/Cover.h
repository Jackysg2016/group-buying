//
//  Cover.h
//  XTuan
//
//  Created by dengwei on 15/8/18.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cover : UIView

+(instancetype)cover;
+(instancetype)coverWithTarget:(id)target action:(SEL)action;

-(void)reset;

@end
