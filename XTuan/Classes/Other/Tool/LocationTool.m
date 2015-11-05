//
//  LocationTool.m
//  XTuan
//
//  Created by dengwei on 15/8/21.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "LocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import "MetaDataTool.h"
#import "City.h"

@interface LocationTool ()<CLLocationManagerDelegate>
{
    CLLocationManager *_mgr;
    CLGeocoder *_geo;
}

@end

@implementation LocationTool

singleton_implementation(LocationTool)

-(instancetype)init
{
    self = [super init];
    if (self) {
        //定位
        _geo = [[CLGeocoder alloc]init];
        _mgr = [[CLLocationManager alloc]init];
        _mgr.delegate = self;
        [_mgr startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [_mgr stopUpdatingLocation];
    
    //根据经纬度反向获取城市名称
    CLLocation *loc = locations[0];
    
    [_geo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = placemarks[0];
        NSString *cityName = place.addressDictionary[@"State"];
        cityName = [cityName substringToIndex:cityName.length - 1];
        City *city = [MetaDataTool sharedMetaDataTool].totalCities[cityName];
        [MetaDataTool sharedMetaDataTool].currentCity = city;
        _locationCity = city;
        _locationCity.position = loc.coordinate;
        XLog(@"name %@", place.name);
        XLog(@"city %@", place.locality);
        XLog(@"district %@", place.subLocality);
    }];
    
}

@end
