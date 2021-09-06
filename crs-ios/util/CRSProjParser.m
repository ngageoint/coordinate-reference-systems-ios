//
//  CRSProjParser.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import "CRSProjParser.h"
#import "CRSReader.h"
#import "CRSEllipsoids.h"
#import "CRSTriaxialEllipsoid.h"
#import "CRSUnits.h"
#import "CRSPrimeMeridians.h"
#import "CRSTextUtils.h"
#import "CRSGeoDatums.h"

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

    [self updateDatumWithParams:params andGeoDatum:geoDatum];

    [self updateDatumTransformWithParams:params andOperationMethod:mapProjection.method];

    [self updateProjWithParams:params andCoordinateSystem:coordinateSystem andMapProjection:mapProjection];
    [self updateUnitsWithParams:params andCoordinateSystem:coordinateSystem];
    [self updatePrimeMeridianWithParams:params andGeoDatum:geoDatum];
    [self updateParams:params withMapProjection:mapProjection];
    
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
    
    NSString *name = [geoDatum name];
    
    CRSGeoDatums *commonGeoDatum = [CRSGeoDatums fromName:name];
    
    if(commonGeoDatum != nil){
        [params setDatum:[commonGeoDatum code]];
    }else{
        [self updateEllipsoidWithParams:params andEllipsoid:[geoDatum ellipsoid]];
    }

}

+(void) updateEllipsoidWithParams: (CRSProjParams *) params andEllipsoid: (CRSEllipsoid *) ellipsoid{

    NSString *name = ellipsoid.name;
    
    CRSEllipsoids *commonEllipsoid = [CRSEllipsoids fromName:name];
    
    if(commonEllipsoid != nil){
        [params setEllps:[commonEllipsoid shortName]];
    }else{
        
        [params setA:ellipsoid.semiMajorAxisText];
        
        switch(ellipsoid.type){
            case CRS_ELLIPSOID_OBLATE:
                [params setB:ellipsoid.inverseFlatteningText];
                break;
            case CRS_ELLIPSOID_TRIAXIAL:
            {
                CRSTriaxialEllipsoid *triaxial = (CRSTriaxialEllipsoid *) ellipsoid;
                [params setB:triaxial.semiMinorAxisText];
                break;
            }
            default:
                [NSException raise:@"Unsupported Type" format:@"Unsupported Ellipsoid Type: %@", [CRSEllipsoidTypes name:ellipsoid.type]];
        }
        
    }

}

+(void) updateDatumTransformWithParams: (CRSProjParams *) params andOperationMethod: (CRSOperationMethod *) method{
    
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

+(void) updatePrimeMeridianWithParams: (CRSProjParams *) params andGeoDatum: (NSObject<CRSGeoDatum> *) geoDatum{
    
    if([geoDatum hasPrimeMeridian]){
        CRSPrimeMeridian *primeMeridian = [geoDatum primeMeridian];
        CRSPrimeMeridians *commonPrimeMeridian = [CRSPrimeMeridians fromName:primeMeridian.name];
        if(commonPrimeMeridian != nil){
            if(commonPrimeMeridian.type != CRS_PM_GREENWICH){
                [params setPm:[commonPrimeMeridian name]];
            }
        }else{
            [params setPm:[self convertValue:primeMeridian.longitude andTextValue:primeMeridian.longitudeText
                                    fromUnit:primeMeridian.longitudeUnit toUnit:[CRSUnits degree]]];
        }
    }
    
}

+(void) updateProjWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{
    
    CRSUnit *unit = [coordinateSystem axisUnit];

    if(unit != nil && (unit.type == CRS_UNIT_ANGLE || (unit.type == CRS_UNIT && [[unit.name lowercaseString] hasPrefix:@"deg"]))){
        [params setProj:@"longlat"];
    }else{
        [params setProj:@"merc"];
    }
}

+(void) updateProjWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem andMapProjection: (CRSMapProjection *) mapProjection{

    CRSOperationMethod *method = mapProjection.method;
    
    if([method hasMethod]){
        
        switch([method.method type]){
                
            case CRS_METHOD_ALBERS_EQUAL_AREA:
                [params setProj:@"aea"];
                break;
                
            case CRS_METHOD_AMERICAN_POLYCONIC:
                [params setProj:@"poly"];
                break;
                
            case CRS_METHOD_CASSINI_SOLDNER:
                [params setProj:@"cass"];
                break;
                
            case CRS_METHOD_EQUIDISTANT_CYLINDRICAL:
                [params setProj:@"eqc"];
                break;
                
            case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_A:
                [params setNo_uoff:YES];
            case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B:
                if([[mapProjection.name lowercaseString] containsString:@"swiss oblique mercator"]){
                    [params setProj:@"somerc"];
                }else{
                    [params setProj:@"omerc"];
                }
                break;
                
            case CRS_METHOD_KROVAK:
                [params setProj:@"krovak"];
                break;
                
            case CRS_METHOD_LAMBERT_AZIMUTHAL_EQUAL_AREA:
                [params setProj:@"laea"];
                break;
                
            case CRS_METHOD_LAMBERT_CONIC_CONFORMAL_1SP:
            case CRS_METHOD_LAMBERT_CONIC_CONFORMAL_2SP:
                [params setProj:@"lcc"];
                break;
                
            case CRS_METHOD_LAMBERT_CYLINDRICAL_EQUAL_AREA:
                [params setProj:@"cea"];
                break;
                
            case CRS_METHOD_MERCATOR_A:
            case CRS_METHOD_MERCATOR_B:
                [params setProj:@"merc"];
                break;
                
            case CRS_METHOD_NEW_ZEALAND_MAP_GRID:
                [params setProj:@"nzmg"];
                break;
                
            case CRS_METHOD_OBLIQUE_STEREOGRAPHIC:
                [params setProj:@"sterea"];
                break;
                
            case CRS_METHOD_POLAR_STEREOGRAPHIC_A:
            case CRS_METHOD_POLAR_STEREOGRAPHIC_B:
            case CRS_METHOD_POLAR_STEREOGRAPHIC_C:
                [params setProj:@"stere"];
                break;
                
            case CRS_METHOD_POPULAR_VISUALISATION_PSEUDO_MERCATOR:
                [params setProj:@"merc"];
                break;
                
            case CRS_METHOD_TRANSVERSE_MERCATOR:
            case CRS_METHOD_TRANSVERSE_MERCATOR_SOUTH_ORIENTATED:
                if([[mapProjection.name lowercaseString] containsString:@"utm zone"]){
                    [params setProj:@"utm"];
                }else{
                    [params setProj:@"tmerc"];
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
        
        enum CRSUnitsType type = [CRSUnits typeFromUnit:coordinateSystem.unit];
        if((int) type != -1){
            
            switch(type){
                case CRS_UNITS_MICROMETRE:
                case CRS_UNITS_MILLIMETRE:
                case CRS_UNITS_METRE:
                case CRS_UNITS_KILOMETRE:
                case CRS_UNITS_GERMAN_LEGAL_METRE:
                    [params setUnits:@"m"];
                    break;
                case CRS_UNITS_US_SURVEY_FOOT:
                    [params setUnits:@"us-ft"];
                    break;
                default:
                    break;
            }
            
        }
        
    }
    
}

+(void) updateAxisWithParams: (CRSProjParams *) params andCoordinateSystem: (CRSCoordinateSystem *) coordinateSystem{

    NSString *axisOrder = [self convertAxes:coordinateSystem.axes];
    // Only known proj4 axis specification is wsu
    if([axisOrder isEqualToString:@"wsu"]) {
        [params setAxis:axisOrder];
    }

}

+(void) updateParams: (CRSProjParams *) params withMapProjection: (CRSMapProjection *) mapProjection{
    
    NSString *name = mapProjection.name;
    NSRange range = [name rangeOfString:@"UTM zone" options:NSCaseInsensitiveSearch];
    if(range.length > 0){
        NSString *utm = [[name substringFromIndex:range.location + range.length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *parts = [utm componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        BOOL south = NO;
        if(parts.count > 0){
            utm = [[parts objectAtIndex:0] uppercaseString];
            south = [utm hasSuffix:@"S"];
            if(south || [utm hasSuffix:@"N"]){
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
            [self updateParams:params withOperationMethod:mapProjection.method];
        }
    }else{
        [self updateParams:params withOperationMethod:mapProjection.method];
    }
    
}

+(void) updateParams: (CRSProjParams *) params withOperationMethod: (CRSOperationMethod *) method{
    if([method hasParameters]){
        for(CRSOperationParameter *parameter in method.parameters){
            [self updateParams:params withOperationMethod:method andOperationParameter:parameter];
        }
    }
}

+(void) updateParams: (CRSProjParams *) params withOperationMethod: (CRSOperationMethod *) method andOperationParameter: (CRSOperationParameter *) parameter{
    
    if([parameter hasParameter]){
        
        switch([parameter.parameter type]){
                
            case CRS_PARAMETER_FALSE_EASTING:
            case CRS_PARAMETER_EASTING_AT_PROJECTION_CENTRE:
            case CRS_PARAMETER_EASTING_AT_FALSE_ORIGIN:
                [params setX_0:[self valueOfParameter:parameter inUnit:[CRSUnits metre]]];
                break;
                
            case CRS_PARAMETER_FALSE_NORTHING:
            case CRS_PARAMETER_NORTHING_AT_PROJECTION_CENTRE:
            case CRS_PARAMETER_NORTHING_AT_FALSE_ORIGIN:
                [params setY_0:[self valueOfParameter:parameter inUnit:[CRSUnits metre]]];
                break;
                
            case CRS_PARAMETER_SCALE_FACTOR_AT_NATURAL_ORIGIN:
            case CRS_PARAMETER_SCALE_FACTOR_ON_INITIAL_LINE:
                [params setK_0:[self valueOfParameter:parameter inUnit:[CRSUnits unity]]];
                break;
                
            case CRS_PARAMETER_LATITUDE_OF_1ST_STANDARD_PARALLEL:
                [params setLat_1:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
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
                        case CRS_METHOD_HOTINE_OBLIQUE_MERCATOR_B:
                            [params setLonc:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
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
                [params setAlpha:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
                break;
                
            case CRS_PARAMETER_ANGLE_FROM_RECTIFIED_TO_SKEW_GRID:
                [params setGamma:[self valueOfParameter:parameter inUnit:[CRSUnits degree]]];
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
                    [axisString appendString:@"e"];
                    break;

                case CRS_AXIS_WEST:
                    [axisString appendString:@"w"];
                    break;

                case CRS_AXIS_NORTH:
                    [axisString appendString:@"n"];
                    break;

                case CRS_AXIS_SOUTH:
                    [axisString appendString:@"s"];
                    break;

                case CRS_AXIS_UP:
                    [axisString appendString:@"u"];
                    break;

                case CRS_AXIS_DOWN:
                    [axisString appendString:@"d"];
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
                [axisString appendString:@"u"];
            }

        }

    }

    return axisValue;
}

+(NSString *) valueOfParameter: (CRSOperationParameter *) parameter inUnit: (CRSUnit *) unit{
    return [self convertValue:parameter.value andTextValue:parameter.valueText fromUnit:parameter.unit toUnit:unit];
}

+(NSString *) convertValue: (double) value andTextValue: (NSString *) textValue fromUnit: (CRSUnit *) fromUnit toUnit: (CRSUnit *) toUnit{
    
    if(fromUnit == nil){
        fromUnit = [CRSUnits defaultUnit:toUnit.type];
    }
    
    if([CRSUnits canConvertBetweenUnit:fromUnit andUnit:toUnit]){
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
