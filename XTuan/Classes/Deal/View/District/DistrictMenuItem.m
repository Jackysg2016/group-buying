//
//  DistrictMenuItem.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DistrictMenuItem.h"
#import "District.h"

@implementation DistrictMenuItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setDistrict:(District *)district
{
    _district = district;
    
    [self setTitle:district.name forState:UIControlStateNormal];
}

-(NSArray *)titles
{
    return _district.neighborhoods;
}

@end
