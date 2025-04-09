//
//  CRSProjParser.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSProjParser.h>
#import <CoordinateReferenceSystems/CRSReader.h>
#import <CoordinateReferenceSystems/CRSTriaxialEllipsoid.h>
#import <CoordinateReferenceSystems/CRSUnits.h>
#import <CoordinateReferenceSystems/CRSPrimeMeridians.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>
#import <CoordinateReferenceSystems/CRSGeoDatums.h>
#import <CoordinateReferenceSystems/CRSProjConstants.h>

@implementation CRSProjParser

+(CRSProjParams *) paramsFromText: (NSString *) wkt{
    
    CRSObject *crs = [CRSReader read:wkt];

    CRSProjParams *params = nil;
    if(crs != nil){
        params = [self paramsFromCRS:crs];
    }

    return params;
}

+(NSString *) paramsTextFromText: (NSString *) wkt{
    return [self paramsText:[self paramsFromText:wkt]];
}

+(CRSProjParams *) paramsFromCRS: (CRSObject *) crs{
    
    CRSProjParams *params = nil;
    
    switch(crs.type){
            
        case CRS_TYPE_GEODETIC:
        case CRS_TYPE_GEOGRAPHIC:
            params = [self paramsFromGeo:(CRSGeoCoordinateReferenceSystem *) crs];
            break;
            
        case CRS_TYPE_PROJECTED:
            params = [self paramsFromProjected:(CRSProjectedCoordinateReferenceSystem *) crs];
            break;
            
        case CRS_TYPE_COMPOUND:
            params = [self paramsFromCompound:(CRSCompoundCoordinateReferenceSystem *) crs];
            break;
            
        default:
            break;
            
    }
    
    return params;
}

+(NSString *) paramsTextFromCRS: (CRSObject *) crs{
    return [self paramsText:[self paramsFromCRS:crs]];
}

+(CRSProjParams *) paramsFromGeo: (CRSGeoCoordinateReferenceSystem *) geo{
    
    CRSProjParams *params = [CRSProjParams params];
    
    NSObject<CRSGeoDatum> *geoDatum = [geo geoDatum];
    
    [self updateDatumWithParams:params andGeoDatum:geoDatum];
    
    [self updateDatumTransformWithParams:params andCRS:geo];
    
    [self updateProjWithParams:params andCoordinateSystem:geo.coordinateSystem];
    [self updatePrimeMeridianWithParams:params andGeoDatum:geoDatum];
    
    [params setNo_defs:YES];
    
    return params;
}

+(NSString *) paramsTextFromGeo: (CRSGeoCoordinateReferenceSystem *) geo{
    return [self paramsText:[self paramsFromGeo:geo]];
}

+(CRSProjParams *) paramsFromProjected: (CRSProjectedCoordinateReferenceSystem *) projected{
    
    CRSProjParams *params = [CRSProjParams params];
    
    CRSCoordinateSystem *coordinateSystem = projected.coordinateSystem;
    CRSMapProjection *mapProjection = projected.mapProjection;

    NSObject<CRSGeoDatum> *geoDatum = [projected geoDatum];

    [self updateDatumWithParams:params andGeoDatum:geoDatum andMapProjection:mapProjection];

    [self updateDatumTransformWithParams:params andCRS:projected.base];
    [self updateDatumTransformWithParams:params andOperationMethod:mapProjection.method];

    [self updateProjWithParams:params andCoordinateSystem:coordinateSystem andMapProjection:mapProjection];
    [self updateUnitsWithParams:params andCoordinateSystem:coordinateSystem];
    [self updatePrimeMeridianWithParams:params andGeoDatum:geoDatum];
    [self updateParams:params withMapProjection:mapProjection andUnit:coordinateSystem.unit];
    
    [params setNo_defs:YES];
    
    return params;
}

+(NSString *) paramsTextFromProjected: (CRSProjectedCoordinateReferenceSystem *) projected{
    return [self paramsText:[self paramsFromProjected:projected]];
}

+(CRSProjParams *) paramsFromCompound: (CRSCompoundCoordinateReferenceSystem *) compound{
    
    CRSProjParams *params = [CRSProjParams params];
    
    for(CRSSimpleCoordinateReferenceSystem *simpleCrs in compound.coordinateReferenceSystems){
        
        params = [self paramsFromCRS:simpleCrs];
        
        if(params != nil){
            break;
        }
        
    }
    
    return params;
}

+(NSString *) paramsTextFromCompound: (CRSCompoundCoordinateReferenceSystem *) compound{
    return [self paramsText:[self paramsFromCompound:compound]];
}

+(void) updateDatumWithParams: (CRSProjParams *) params andGeoDatum: (NSObject<CRSGeoDatum> *) geoDatum{
    
    CRSGeoDatums *commonGeoDatum = [CRSGeoDatums fromName:[geoDatum name]];
    
    // Check for special cases like EPSG 4258 which specify the ellipsoid
    if(commonGeoDatum != nil && commonGeoDatum.type != CRS_DATUM_ETRS89){
        [params setDatum:[commonGeoDatum code]];
    }else{
        [self updateEllipsoidWithParams:params andEllipsoid:[geoDatum ellipsoid]];
    }

}

+(void) updateDatumWithParams: (CRSProjParams *) params andGeoDatum: (NSObject<CRSGeoDatum> *) geoDatum andMapProjection: (CRSMapProjection *) mapProjection{
    
    CRSGeoDatums *commonGeoDatum = [CRSGeoDatums fromName:[geoDatum name]];
    
    // Check for special cases like EPSG 3035 which specify the ellipsoid
    if(commonGeoDatum != nil && commonGeoDatum.type != CRS_DATUM_ETRS89){
        [self updateDatumWithParams:params andGeoDatum:geoDatum andCommonGeoDatum:commonGeoDatum andMapProjection:mapProjection];
    }else{
        [self updateEllipsoidWithParams:params andEllipsoid:[geoDatum ellipsoid]];
    }
}

+(void) updateDatumWithParams: (CRSProjParams *) params andGeoDatum: (NSObject<CRSGeoDatum> *) geoDatum andCommonGeoDatum: (CRSGeoDatums *) commonGeoDatum andMapProjection: (CRSMapProjection *) mapProjection{
    CRSOperationMethod *method = mapProjection.method;
    // Check for special cases like EPSG 3857 which specifies the ellipsoid parameters instead of a datum
    if(commonGeoDatum.type == CRS_DATUM_WGS84
       && [method hasMethod] && method.method.type == CRS_METHOD_POPULAR_VISUALISATION_PSEUDO_MERCATOR
       && [mapProjection.name rangeOfString:CRS_PROJ_PSEUDO_MERCATOR options:NSCaseInsensitiveSearch].length > 0){
        [self updateSphericalEllipsoidWithParams:params andRadius:[geoDatum ellipsoid].semiMajorAxisText];
    }else{
        [params setDatum:[commonGeoDatum code]];
    }
}

+(void) updateEllipsoidWithParams: (CRSProjParams *) params andEllipsoid: (CRSEllipsoid *) ellipsoid{
    
    CRSEllipsoids *commonEllipsoid = nil;
    
    if(ellipsoid.inverseFlattening != 0){
        commonEllipsoid = [CRSEllipsoids fromName:ellipsoid.name];
    }
    
    if(commonEllipsoid != nil){
        [params setEllps:[commonEllipsoid shortName]];
    }else{
        
        [params setA:[self convertValue:ellipsoid.semiMajorAxis andTextValue:ellipsoid.semiMajorAxisText fromUnit:ellipsoid.unit toUnit:[CRSUnits metre]]];
        
        switch(ellipsoid.type){
            case CRS_ELLIPSOID_OBLATE:
                [params setB:[self convertValue:[ellipsoid poleRadius] andTextValue:[ellipsoid poleRadiusText] fromUnit:ellipsoid.unit toUnit:[CRSUnits metre]]];
                break;
            case CRS_ELLIPSOID_TRIAXIAL:
            {
                CRSTriaxialEllipsoid *triaxial = (CRSTriaxialEllipsoid *) ellipsoid;
                [params setB:[self convertValue:triaxial.semiMinorAxis andTextValue:triaxial.semiMinorAxisText fromUnit:ellipsoid.unit toUnit:[CRSUnits metre]]];
                break;
            }
            default:
                [NSException raise:@"Unsupported Type" format:@"Unsupported Ellipsoid Type: %@", [CRSEllipsoidTypes name:ellipsoid.type]];
        }
        
    }

}

+(void) updateSphericalEllipsoidWithParams: (CRSProjParams *) params andRadius: (NSString *) radius{
    [params setA:radius];
    [params setB:radius];
}

+(void) updateDatumTransformWithParams: (CRSProjParams *) params andCRS: (CRSObject *) crs{
    NSObject *toWGS84 = [crs extraWithName:[CRSKeyword nameOfType:CRS_KEYWORD_TOWGS84]];
    if(toWGS84 != nil){
        [self updateDatumTransformWithParams:params andToWGS84:(NSArray<NSString *> *)toWGS84];
    }
}

+(void) updateDatumTransformWithParams: (CRSProjParams *) params andToWGS84: (NSArray<NSString *> *) toWGS84{
    if(toWGS84.count >=3){
        [params setXTranslation:[toWGS84 objectAtIndex:0]];
        [params setYTranslation:[toWGS84 objectAtIndex:1]];
        [params setZTranslation:[toWGS84 objectAtIndex:2]];
        if(toWGS84.count >=7){
            [params setXRotation:[toWGS84 objectAtIndex:3]];
            [params setYRotation:[toWGS84 objectAtIndex:4]];
            [params setZRotation:[toWGS84 objectAtIndex:5]];
            [params setScaleDifference:[toWGS84 objectAtIndex:6]];
        }
    }
}

+(void) updateDatumTransformWithParams: (CRSProjParams *) params andOperationMethod: (CRSOperationMethod *) method{
    
    if([method hasParameters]){
    
        for(CRSOperationParameter *parameter in method.parameters){
            
            if([parameter hasParameter]){
            
                switch([parameter.parameter type]){
                        
                    case CRS_PARAMETER_X_AXIS_TRANSLATION:
                        [params setXTranslation:[self valueOfParameter:parameter inUnit:[CRSUnits metre]]];
                        break;
                        
                    case CRS_PARAMETER_Y_AXIS_TRANSLATION:
                        [params setYTranslation:[self valueOfParameter:parameter inUnit:[CRSUnits metre]]];
                        break;
                        
                    case CRS_PARAMETER_Z_AXIS_TRANSLATION:
                        [params setZTranslation:[self valueOfParameter:parameter inUnit:[CRSUnits metre]]];
                        break;
                        
                    case CRS_PARAMETER_X_AXIS_ROTATION:
                        [params setXRotation:[self valueOfParameter:parameter inUnit:[CRSUnits arcSecond]]];
                        break;
                        
                    case CRS_PARAMETER_Y_AXIS_ROTATION:
                        [params setYRotation:[self valueOfParameter:parameter inUnit:[CRSUnits arcSecond]]];
                        break;
                        
                    case CRS_PARAMETER_Z_AXIS_ROTATION:
                        [params setZRotation:[self valueOfParameter:parameter inUnit:[CRSUnits arcSecond]]];
                        break;
                        
                    case CRS_PARAMETER_SCALE_DIFFERENCE:
                        [params setScaleDifference:[self valueOfParameter:parameter inUnit:[CRSUnits partsPerMillion]]];
                        break;
                        
                    default:
                        break;
                        
                }
            }
        }
    
    }
        
}

+(void) updatePrimeMeridianWithParams: (CRSProjParams *) params andGeoDatum: (NSObject<CRSGeoDatum> *) geoDatum{
    
    if([geoDatum hasPrimeMeridian]){
        CRSPrimeMeridian *primeMeridian = [geoDatum primeMeridian];
        CRSPrimeMeridians *commonPrimeMeridian = [CRSPrimeMeridians fromName:primeMeridian.name];
        if(commonPrimeMeridian != nil){
            if(commonPrimeMeridian.type != CRS_PM_GREENWICH){
                [params setPm:[[commonPrimeMeridian name] lowercaseString]];
            }
        }else{
            [params setPm:[self convertValue:primeMeridian.longitude andTextValue:primeMeridian.longitudeText
                                    fromUnit:primeMeridian.longitudeUnit toUnit:[CRSUnits degree]]];
        }
    }
    
}

+(void) updateProjWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    
    CRSUnit *unit = [coordinateSystem axisUnit];

    if(unit != nil && (unit.type == CRS_UNIT_ANGLE || (unit.type == CRS_UNIT && [[unit.name lowercaseString] hasPrefix:CRS_PROJ_UNITS_DEGREE]))){
        [params setProj:CRS_PROJ_NAME_LONGLAT];
    }else{
        [params setProj:CRS_PROJ_NAME_MERC];
    }
}

+(void) updateProjWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem andMapProjection: (CRSMapProjection *) mapProjection{

    CRSOperationMethod *method = mapProjection.method;
    
    if([method hasMethod]){
        
        switch([method.method type]){
                
            case CRS_METHOD_ALBERS_EQUAL_AREA:
                [params setProj:CRS_PROJ_NAME_AEA];
                break;
                
            case CRS_METHOD_AMERICAN_POLYCONIC:
                [params setProj:CRS_PROJ_NAME_POLY];
                break;
                
            case CRS_METHOD_CASSINI_SOLDNER:
                [params setProj:CRS_PROJ_NAME_CASS];
                break;
                
            case CRS_METHOD_EQUIDISTANT_CYLINDRICAL:
                [params setProj:CRS_PROJ_NAME_EQC];
                break;
                
            case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_A:
                [params setNo_uoff:YES];
                [params setProj:CRS_PROJ_NAME_OMERC];
                break;
                
            case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B:
                if([[mapProjection.name lowercaseString] containsString:CRS_PROJ_SWISS_OBLIQUE_MERCATOR]
                   || [[method.name lowercaseString] containsString:CRS_PROJ_SWISS_OBLIQUE_MERCATOR_COMPAT]){
                    [params setProj:CRS_PROJ_NAME_SOMERC];
                }else{
                    [params setProj:CRS_PROJ_NAME_OMERC];
                }
                break;
                
            case CRS_METHOD_KROVAK:
                [params setProj:CRS_PROJ_NAME_KROVAK];
                break;
                
            case CRS_METHOD_LAMBERT_AZIMUTHAL_EQUAL_AREA:
                [params setProj:CRS_PROJ_NAME_LAEA];
                break;
                
            case CRS_METHOD_LAMBERT_CONIC_CONFORMAL_1SP:
            case CRS_METHOD_LAMBERT_CONIC_CONFORMAL_2SP:
                [params setProj:CRS_PROJ_NAME_LCC];
                break;
                
            case CRS_METHOD_LAMBERT_CYLINDRICAL_EQUAL_AREA:
                [params setProj:CRS_PROJ_NAME_CEA];
                break;
                
            case CRS_METHOD_MERCATOR_A:
            case CRS_METHOD_MERCATOR_B:
                [params setProj:CRS_PROJ_NAME_MERC];
                break;
                
            case CRS_METHOD_NEW_ZEALAND_MAP_GRID:
                [params setProj:CRS_PROJ_NAME_NZMG];
                break;
                
            case CRS_METHOD_OBLIQUE_STEREOGRAPHIC:
                [params setProj:CRS_PROJ_NAME_STEREA];
                break;
                
            case CRS_METHOD_POLAR_STEREOGRAPHIC_A:
            case CRS_METHOD_POLAR_STEREOGRAPHIC_B:
            case CRS_METHOD_POLAR_STEREOGRAPHIC_C:
                [params setProj:CRS_PROJ_NAME_STERE];
                break;
                
            case CRS_METHOD_POPULAR_VISUALISATION_PSEUDO_MERCATOR:
                [params setProj:CRS_PROJ_NAME_MERC];
                break;
                
            case CRS_METHOD_TRANSVERSE_MERCATOR:
            case CRS_METHOD_TRANSVERSE_MERCATOR_SOUTH_ORIENTATED:
                if([[mapProjection.name lowercaseString] containsString:CRS_PROJ_UTM_ZONE]){
                    [params setProj:CRS_PROJ_NAME_UTM];
                }else{
                    [params setProj:CRS_PROJ_NAME_TMERC];
                }
                break;
                
            default:
                break;
                
        }
        
        if (params.proj != nil) {
            [self updateAxisWithParams:params andCoordinateSystem:coordinateSystem];
        }
        
    }

    if(params.proj == nil){
        [self updateProjWithParams:params andCoordinateSystem:coordinateSystem];
    }
    
}

+(void) updateUnitsWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    
    if([coordinateSystem hasUnit]){
        
        CRSUnit *unit = coordinateSystem.unit;
        
        if(unit.type == CRS_UNIT_LENGTH || unit.type == CRS_UNIT){
            
            CRSUnitsType type = [CRSUnits typeFromUnit:unit];
            if((int) type != -1){
                
                switch(type){
                    case CRS_UNITS_MICROMETRE:
                    case CRS_UNITS_MILLIMETRE:
                    case CRS_UNITS_METRE:
                    case CRS_UNITS_KILOMETRE:
                        [params setUnits:CRS_PROJ_UNITS_METRE];
                        break;
                    case CRS_UNITS_US_SURVEY_FOOT:
                        [params setUnits:CRS_PROJ_UNITS_US_SURVEY_FOOT];
                        break;
                    case CRS_UNITS_FOOT:
                        [params setUnits:CRS_PROJ_UNITS_FOOT];
                        break;
                    default:
                        break;
                }
                
            }
            
            if(params.units == nil && [unit hasConversionFactor] && [unit.conversionFactor doubleValue] != 1.0){
                [params setTo_meter:unit.conversionFactorText];
            }
            
        }
        
    }
    
}

+(void) updateAxisWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    NSString *axisOrder = [self convertAxes:coordinateSystem.axes];
    [params setAxis:axisOrder];
}

+(void) updateParams: (CRSProjParams *) params withMapProjection: (CRSMapProjection *) mapProjection andUnit: (CRSUnit *) unit{
    
    NSString *name = mapProjection.name;
    NSRange range = [name rangeOfString:CRS_PROJ_UTM_ZONE options:NSCaseInsensitiveSearch];
    if(range.length > 0){
        NSString *utm = [[name substringFromIndex:range.location + range.length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *parts = [utm componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        BOOL south = NO;
        if(parts.count > 0){
            utm = [[parts objectAtIndex:0] lowercaseString];
            south = [utm hasSuffix:CRS_PROJ_AXIS_SOUTH];
            if(south || [utm hasSuffix:CRS_PROJ_AXIS_NORTH]){
                utm = [utm substringToIndex:utm.length - 1];
            }
        }
        NSScanner *scanner = [NSScanner scannerWithString:utm];
        if([scanner scanInt:nil]){
            [params setZone:utm];
            if(south){
                [params setSouth:YES];
            }
        }else{
            [self updateParams:params withOperationMethod:mapProjection.method andUnit:unit];
        }
    }else{
        [self updateParams:params withOperationMethod:mapProjection.method andUnit:unit];
    }
    
}

+(void) updateParams: (CRSProjParams *) params withOperationMethod: (CRSOperationMethod *) method andUnit: (CRSUnit *) unit{
    if([method hasParameters]){
        for(CRSOperationParameter *parameter in method.parameters){
            [self updateParams:params withOperationMethod:method andUnit:unit andOperationParameter:parameter];
        }
    }
}

+(void) updateParams: (CRSProjParams *) params withOperationMethod: (CRSOperationMethod *) method andUnit: (CRSUnit *) unit andOperationParameter: (CRSOperationParameter *) parameter{
    
    if([parameter hasParameter]){
        
        switch([parameter.parameter type]){
                
            case CRS_PARAMETER_FALSE_EASTING:
            case CRS_PARAMETER_EASTING_AT_PROJECTION_CENTRE:
            case CRS_PARAMETER_EASTING_AT_FALSE_ORIGIN:
                [params setX_0:[self valueOfParameter:parameter withUnit:unit inUnit:[CRSUnits metre]]];
                break;
                
            case CRS_PARAMETER_FALSE_NORTHING:
            case CRS_PARAMETER_NORTHING_AT_PROJECTION_CENTRE:
            case CRS_PARAMETER_NORTHING_AT_FALSE_ORIGIN:
                [params setY_0:[self valueOfParameter:parameter withUnit:unit inUnit:[CRSUnits metre]]];
                break;
                
            case CRS_PARAMETER_SCALE_FACTOR_AT_NATURAL_ORIGIN:
            case CRS_PARAMETER_SCALE_FACTOR_ON_INITIAL_LINE:
            case CRS_PARAMETER_SCALE_FACTOR_ON_PSEUDO_STANDARD_PARALLEL:
                [params setK_0:[self valueOfParameter:parameter inUnit:[CRSUnits unity]]];
                break;
                
            case CRS_PARAMETER_LATITUDE_OF_1ST_STANDARD_PARALLEL:
                if([method hasMethod]){
                    switch([method.method type]){
                        case CRS_METHOD_LAMBERT_CYLINDRICAL_EQUAL_AREA:
                            [params setLat_ts:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                        default:
                            [params setLat_1:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                    }
                }else{
                    [params setLat_1:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                }
                break;
                
            case CRS_PARAMETER_LATITUDE_OF_2ND_STANDARD_PARALLEL:
                [params setLat_2:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                break;
                
            case CRS_PARAMETER_LATITUDE_OF_PROJECTION_CENTRE:
            case CRS_PARAMETER_LATITUDE_OF_NATURAL_ORIGIN:
            case CRS_PARAMETER_LATITUDE_OF_FALSE_ORIGIN:
                if([method hasMethod]){
                    switch([method.method type]){
                        case CRS_METHOD_POLAR_STEREOGRAPHIC_A:
                        case CRS_METHOD_POLAR_STEREOGRAPHIC_B:
                        case CRS_METHOD_POLAR_STEREOGRAPHIC_C:
                            [params setLat_ts:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            if([params.lat_ts doubleValue] >= 0){
                                [params setLat_0:@"90"];
                            }else{
                                [params setLat_0:@"-90"];
                            }
                            break;
                        case CRS_METHOD_EQUIDISTANT_CYLINDRICAL:
                            [params setLat_ts:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            [params setLat_0:@"0"];
                            break;
                        case CRS_METHOD_LAMBERT_CYLINDRICAL_EQUAL_AREA:
                        case CRS_METHOD_MERCATOR_A:
                        case CRS_METHOD_MERCATOR_B:
                        case CRS_METHOD_POPULAR_VISUALISATION_PSEUDO_MERCATOR:
                            [params setLat_ts:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                        case CRS_METHOD_LAMBERT_CONIC_CONFORMAL_1SP:
                        case CRS_METHOD_LAMBERT_CONIC_CONFORMAL_2SP:
                            [params setLat_0:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            if(params.lat_1 == nil){
                                [params setLat_1:params.lat_0];
                            }
                            break;
                        default:
                            [params setLat_0:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                    }
                }else{
                    [params setLat_0:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                }
                break;
                
            case CRS_PARAMETER_LONGITUDE_OF_PROJECTION_CENTRE:
            case CRS_PARAMETER_LONGITUDE_OF_NATURAL_ORIGIN:
            case CRS_PARAMETER_LONGITUDE_OF_FALSE_ORIGIN:
            case CRS_PARAMETER_LONGITUDE_OF_ORIGIN:
                if([method hasMethod]){
                    switch([method.method type]){
                        case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_A:
                            [params setLonc:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                        case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B:
                            if(params.proj != nil && [params.proj isEqualToString:CRS_PROJ_NAME_SOMERC]){
                                [params setLon_0:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            }else{
                                [params setLonc:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            }
                            break;
                        default:
                            [params setLon_0:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                    }
                }else{
                    [params setLon_0:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                }
                break;
                
            case CRS_PARAMETER_AZIMUTH_OF_INITIAL_LINE:
            case CRS_PARAMETER_CO_LATITUDE_OF_CONE_AXIS:
                if([method hasMethod]){
                    switch([method.method type]){
                        case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B:
                            if(params.proj == nil || ![params.proj isEqualToString:CRS_PROJ_NAME_SOMERC]){
                                [params setAlpha:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            }
                            break;
                        default:
                            [params setAlpha:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                    }
                }else{
                    [params setAlpha:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                }
                break;
                
            case CRS_PARAMETER_ANGLE_FROM_RECTIFIED_TO_SKEW_GRID:
                if([method hasMethod]){
                    switch([method.method type]){
                        case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B:
                            if(params.proj == nil || ![params.proj isEqualToString:CRS_PROJ_NAME_SOMERC]){
                                [params setGamma:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            }
                            break;
                        default:
                            [params setGamma:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                            break;
                    }
                }else{
                    [params setGamma:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                }
                break;
                
            default:
                break;
                
        }
        
    }
    
}

+(NSString *) convertAxes: (NSArray<CRSAxis *> *) axes{

    NSString *axisValue = nil;

    NSUInteger axesCount = axes.count;
    if(axesCount == 2 || axesCount == 3){

        NSMutableString *axisString = [NSMutableString string];

        for(CRSAxis *axis in axes){

            switch(axis.direction){

                case CRS_AXIS_EAST:
                    [axisString appendString:CRS_PROJ_AXIS_EAST];
                    break;

                case CRS_AXIS_WEST:
                    [axisString appendString:CRS_PROJ_AXIS_WEST];
                    break;

                case CRS_AXIS_NORTH:
                    [axisString appendString:CRS_PROJ_AXIS_NORTH];
                    break;

                case CRS_AXIS_SOUTH:
                    [axisString appendString:CRS_PROJ_AXIS_SOUTH];
                    break;

                case CRS_AXIS_UP:
                    [axisString appendString:CRS_PROJ_AXIS_UP];
                    break;

                case CRS_AXIS_DOWN:
                    [axisString appendString:CRS_PROJ_AXIS_DOWN];
                    break;

                default:
                    axisString = nil;
                    break;

            }

            if(axisString == nil){
                break;
            }
        }

        if(axisString != nil){

            if(axesCount == 2){
                [axisString appendString:CRS_PROJ_AXIS_UP];
            }

            axisValue = axisString;
        }

    }

    return axisValue;
}

+(NSString *) valueOfParameter: (CRSOperationParameter *) parameter withUnit: (CRSUnit*) unit inUnit: (CRSUnit *) inUnit{
    CRSUnit *parameterUnit = parameter.unit;
    if(parameterUnit == nil){
        parameterUnit = unit;
    }
    return [self convertValue:parameter.value andTextValue:parameter.valueText fromUnit:parameterUnit toUnit:inUnit];
}

+(NSString *) valueOfParameter: (CRSOperationParameter *) parameter inUnit: (CRSUnit *) unit{
    return [self convertValue:parameter.value andTextValue:parameter.valueText fromUnit:parameter.unit toUnit:unit];
}

+(NSString *) convertValue: (double) value andTextValue: (NSString *) textValue fromUnit: (CRSUnit *) fromUnit toUnit: (CRSUnit *) toUnit{
    
    if(fromUnit == nil){
        fromUnit = [CRSUnits defaultUnit:toUnit.type];
    }
    
    if(value != 0.0 && [CRSUnits canConvertBetweenUnit:fromUnit andUnit:toUnit] && ![fromUnit isEqualNameToUnit:toUnit]){
        value = [CRSUnits convertValue:value fromUnit:fromUnit toUnit:toUnit];
        textValue = [CRSTextUtils textFromDouble:value];
    }
    
    return textValue;
}

+(NSString *) paramsText: (CRSProjParams *) params{
    NSString *text = nil;
    if(params != nil){
        text = [params description];
    }
    return text;
}

@end
