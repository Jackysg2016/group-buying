//
//  DealPosAnnotationModel.h
//  XTuan
//
//  Created by dengwei on 15/8/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class DealModel,BusinessModel;
@interface DealPosAnnotationModel : NSObject <MKAnnotation>

@property(nonatomic, assign)CLLocationCoordinate2D coordinate;

@property(nonatomic, strong)DealModel *deal; //显示的是哪种团购
@property(nonatomic, strong)BusinessModel *business; //显示的是哪个商家
@property(nonatomic, copy)NSString *icon;

@end
