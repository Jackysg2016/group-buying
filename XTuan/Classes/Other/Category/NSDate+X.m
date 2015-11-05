//
//  NSDate+X.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "NSDate+X.h"

@implementation NSDate (X)

+(NSDateComponents *)compareForm:(NSDate *)from to:(NSDate *)to
{
    //日历对象（标识：时区相关的标识）
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //合并标记
    NSInteger flags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    //进行比较
    NSDateComponents *comps = [calendar components:flags fromDate:from toDate:to options:0];
    
    return comps;
}

-(NSDateComponents *)compare:(NSDate *)other
{
    return [NSDate compareForm:self to:other];
}

@end