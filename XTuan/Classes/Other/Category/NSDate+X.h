//
//  NSDate+X.h
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (X)

/**
 *  比较两个时间
 *
 *  @param from 起始时间
 *  @param to   结束时间
 *
 *  @return NSDateComponents
 */
+(NSDateComponents *)compareForm:(NSDate *)from to:(NSDate *)to;

-(NSDateComponents *)compare:(NSDate *)other;

@end
