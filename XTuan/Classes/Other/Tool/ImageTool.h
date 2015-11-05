//
//  ImageTool.h
//  XTuan
//
//  Created by dengwei on 15/8/17.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageTool : NSObject

+(void)downloadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView;

+(void)clearImageCache;

@end
