//
//  LocationTool.h
//  XTuan
//
//  Created by dengwei on 15/8/21.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//  定位

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class City;
@interface LocationTool : NSObject

singleton_interface(LocationTool)

@property(nonatomic, strong)City *locationCity; //定位城市

@end
