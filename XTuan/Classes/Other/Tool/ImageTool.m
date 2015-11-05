//
//  ImageTool.m
//  XTuan
//
//  Created by dengwei on 15/8/17.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "ImageTool.h"
#import "UIImageView+WebCache.h"

@implementation ImageTool

+(void)downloadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

+(void)clearImageCache
{
    //清除内存中的缓存文件
    [[SDImageCache sharedImageCache] clearMemory];
    
    //取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
