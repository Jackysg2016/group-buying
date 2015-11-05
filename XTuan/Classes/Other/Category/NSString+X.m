//
//  NSString+X.m
//  XTuan
//
//  Created by dengwei on 15/8/17.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "NSString+X.h"

@implementation NSString (X)

+(NSString *)stringWithDouble:(double)value decimalsCount:(int)decimalsCount
{
    if (decimalsCount < 0) {
        return nil;
    }
    
    //生成格式字符串
    NSString *fmt = [NSString stringWithFormat:@"%%.%df", decimalsCount];
    
    //生成保留decimalsCount位小数的字符串
    NSString *str = [NSString stringWithFormat:fmt, value];
    
    //没有小数，直接返回
    if ([str rangeOfString:@"."].length == 0) {
        return str;
    }
    
    //从最后面往前找，不断删除最后面的0和最后一个“.”
    int index = str.length - 1;
    unichar currentChar = [str characterAtIndex:index];
    for (; currentChar == '0' || currentChar == '.'; index--, currentChar = [str characterAtIndex:index]) {
        //裁减到“.”直接返回
        if (currentChar == '.') {
            return [str substringToIndex:index];
        }
    }
    
    str = [str substringToIndex:index + 1];
    
    return str;
}

@end
