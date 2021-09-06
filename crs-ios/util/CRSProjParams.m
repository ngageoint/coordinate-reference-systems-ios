//
//  CRSProjParams.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSProjParams.h"

@implementation CRSProjParams

+(CRSProjParams *) params{
    return [[CRSProjParams alloc] init];
}

-(instancetype) init{
    self = [super init];
    return self;
}

-(NSString *) description{
    NSMutableString *description = [NSMutableString string];
    
    if(_proj != nil){
        [description appendFormat:@"+proj=%@", _proj];
    }
    if(_zone != nil){
        [description appendFormat:@" +zone=%@", _zone];
    }
    if(_south){
        [description appendFormat:@" +south"];
    }
    if(_lat_1 != nil){
        [description appendFormat:@" +lat_1=%@", _lat_1];
    }
    if(_lat_2 != nil){
        [description appendFormat:@" +lat_2=%@", _lat_2];
    }
    if(_lat_0 != nil){
        [description appendFormat:@" +lat_0=%@", _lat_0];
    }
    if(_lat_ts != nil){
        [description appendFormat:@" +lat_ts=%@", _lat_ts];
    }
    if(_lon_0 != nil){
        [description appendFormat:@" +lon_0=%@", _lon_0];
    }
    if(_lonc != nil){
        [description appendFormat:@" +lonc=%@", _lonc];
    }
    if(_alpha != nil){
        [description appendFormat:@" +alpha=%@", _alpha];
    }
    if(_k_0 != nil){
        [description appendFormat:@" +k_0=%@", _k_0];
    }
    if(_x_0 != nil){
        [description appendFormat:@" +x_0=%@", _x_0];
    }
    if(_y_0 != nil){
        [description appendFormat:@" +y_0=%@", _y_0];
    }
    if(_axis != nil){
        [description appendFormat:@" +axis=%@", _axis];
    }
    if(_datum != nil){
        [description appendFormat:@" +datum=%@", _datum];
    }
    if(_no_uoff){
        [description appendFormat:@" +no_uoff"];
    }
    if(_gamma != nil){
        [description appendFormat:@" +gamma=%@", _gamma];
    }
    if(_a != nil){
        [description appendFormat:@" +a=%@", _a];
    }
    if(_b != nil){
        [description appendFormat:@" +b=%@", _b];
    }
    if(_ellps != nil){
        [description appendFormat:@" +ellps=%@", _ellps];
    }
    if(_towgs84 != nil){
        [description appendFormat:@" +towgs84=%@", _towgs84];
    }else if(_xTranslation != nil
             || _yTranslation != nil
             || _zTranslation != nil
             || _xRotation != nil
             || _yRotation != nil
             || _zRotation != nil
             || _scaleDifference != nil){
        [description appendFormat:@" +towgs84=%@,%@,%@,%@,%@,%@,%@",
         _xTranslation != nil ? _xTranslation : @"0",
         _yTranslation != nil ? _yTranslation : @"0",
         _zTranslation != nil ? _zTranslation : @"0",
         _xRotation != nil ? _xRotation : @"0",
         _yRotation != nil ? _yRotation : @"0",
         _zRotation != nil ? _zRotation : @"0",
         _scaleDifference != nil ? _scaleDifference : @"0"];
    }
    if(_pm != nil){
        [description appendFormat:@" +pm=%@", _pm];
    }
    if(_units != nil){
        [description appendFormat:@" +units=%@", _units];
    }
    if(_no_defs){
        [description appendFormat:@" +no_defs"];
    }
    
    return description;
}

@end
