//
//  CRSProjParams.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSProjParams.h>
#import <CoordinateReferenceSystems/CRSProjConstants.h>

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
        [description appendFormat:@"+%@=%@", CRS_PROJ_PARAM_PROJ, _proj];
    }
    if(_zone != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_ZONE, _zone];
    }
    if(_south){
        [description appendFormat:@" +%@", CRS_PROJ_PARAM_SOUTH];
    }
    if(_lat_1 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_LAT_1, _lat_1];
    }
    if(_lat_2 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_LAT_2, _lat_2];
    }
    if(_lat_0 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_LAT_0, _lat_0];
    }
    if(_lat_ts != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_LAT_TS, _lat_ts];
    }
    if(_lon_0 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_LON_0, _lon_0];
    }
    if(_lonc != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_LONC, _lonc];
    }
    if(_alpha != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_ALPHA, _alpha];
    }
    if(_k_0 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_K_0, _k_0];
    }
    if(_x_0 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_X_0, _x_0];
    }
    if(_y_0 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_Y_0, _y_0];
    }
    if(_axis != nil && [_axis isEqualToString:CRS_PROJ_AXIS_WEST_SOUTH_UP]){
        // Only known PROJ axis specification is wsu
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_AXIS, _axis];
    }
    if(_datum != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_DATUM, _datum];
    }
    if(_no_uoff){
        [description appendFormat:@" +%@", CRS_PROJ_PARAM_NO_UOFF];
    }
    if(_gamma != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_GAMMA, _gamma];
    }
    if(_a != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_A, _a];
    }
    if(_b != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_B, _b];
    }
    if(_ellps != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_ELLPS, _ellps];
    }
    if(_towgs84 != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_TOWGS84, _towgs84];
    }else if(_xTranslation != nil
             || _yTranslation != nil
             || _zTranslation != nil
             || _xRotation != nil
             || _yRotation != nil
             || _zRotation != nil
             || _scaleDifference != nil){
        [description appendFormat:@" +%@=%@,%@,%@,%@,%@,%@,%@",
         CRS_PROJ_PARAM_TOWGS84,
         _xTranslation != nil ? _xTranslation : @"0",
         _yTranslation != nil ? _yTranslation : @"0",
         _zTranslation != nil ? _zTranslation : @"0",
         _xRotation != nil ? _xRotation : @"0",
         _yRotation != nil ? _yRotation : @"0",
         _zRotation != nil ? _zRotation : @"0",
         _scaleDifference != nil ? _scaleDifference : @"0"];
    }
    if(_pm != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_PM, _pm];
    }
    if(_units != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_UNITS, _units];
    }
    if(_to_meter != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_TO_METER, _to_meter];
    }
    if(_nadgrids != nil){
        [description appendFormat:@" +%@=%@", CRS_PROJ_PARAM_NADGRIDS, _nadgrids];
    }
    if(_wktext){
        [description appendFormat:@" +%@", CRS_PROJ_PARAM_WKTEXT];
    }
    if(_no_defs){
        [description appendFormat:@" +%@", CRS_PROJ_PARAM_NO_DEFS];
    }
    
    return description;
}

@end
