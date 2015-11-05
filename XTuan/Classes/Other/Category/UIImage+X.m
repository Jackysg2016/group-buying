//
//  UIImage+X.m
//  iWeibo
//
//  Created by dengwei on 15/7/29.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "UIImage+X.h"

@implementation UIImage (X)

#pragma mark 可以自由拉伸不会变形的图片
+(UIImage *)resizedImage:(NSString *)imageName
{
    
    return [self resizedImage:imageName xPos:0.5 yPos:0.5];
    
}


+ (UIImage *)resizedImage:(NSString *)imageName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
