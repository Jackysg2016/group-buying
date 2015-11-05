//
//  Dock.h
//  XTuan
//
//  Created by dengwei on 15/8/13.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dock;
@protocol DockDelegate <NSObject>
@optional
-(void)dock:(Dock *)dock tabChangedFrom:(int)from to:(int)to;

@end

@interface Dock : UIView

@property(nonatomic, weak)id<DockDelegate> delegate;

@end
