//
//  CRSPrimeMeridians.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSPrimeMeridians.h>
#import <CoordinateReferenceSystems/CRSUnits.h>

@interface CRSPrimeMeridians()

@property (nonatomic) CRSPrimeMeridianType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) double offsetFromGreenwich;

@end

@implementation CRSPrimeMeridians

/**
 * Type to Prime Meridian mapping
 */
static NSMutableDictionary<NSNumber *, CRSPrimeMeridians *> *typePrimeMeridians = nil;

/**
 * Name to Prime Meridian mapping
 */
static NSMutableDictionary<NSString *, CRSPrimeMeridians *> *namePrimeMeridians = nil;

+(void) initialize{
    typePrimeMeridians = [NSMutableDictionary dictionary];
    namePrimeMeridians = [NSMutableDictionary dictionary];
 
    [self initializePrimeMeridian:[self createWithType:CRS_PM_GREENWICH andName:@"Greenwich" andOffset:0]];
    [self initializePrimeMeridian:[self westWithType:CRS_PM_LISBON andName:@"Lisbon" andDegree:9 andMinute:7 andSecond:54.862]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_PARIS andName:@"Paris" andDegree:2 andMinute:20 andSecond:14.025]];
    [self initializePrimeMeridian:[self westWithType:CRS_PM_BOGOTA andName:@"Bogota" andDegree:74 andMinute:04 andSecond:51.3]];
    [self initializePrimeMeridian:[self westWithType:CRS_PM_MADRID andName:@"Madrid" andDegree:3 andMinute:41 andSecond:16.58]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_ROME andName:@"Rome" andDegree:12 andMinute:27 andSecond:8.4]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_BERN andName:@"Bern" andDegree:7 andMinute:26 andSecond:22.5]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_JAKARTA andName:@"Jakarta" andDegree:106 andMinute:48 andSecond:27.79]];
    [self initializePrimeMeridian:[self westWithType:CRS_PM_FERRO andName:@"Ferro" andDegree:17 andMinute:40 andSecond:0]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_BRUSSELS andName:@"Brussels" andDegree:4 andMinute:22 andSecond:4.71]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_STOCKHOLM andName:@"Stockholm" andDegree:18 andMinute:3 andSecond:29.8]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_ATHENS andName:@"Athens" andDegree:23 andMinute:42 andSecond:58.815]];
    [self initializePrimeMeridian:[self eastWithType:CRS_PM_OSLO andName:@"Oslo" andDegree:10 andMinute:43 andSecond:22.5]];
    
}

+(void) initializePrimeMeridian: (CRSPrimeMeridians *) primeMeridian{
    
    [typePrimeMeridians setObject:primeMeridian forKey:[NSNumber numberWithInt:primeMeridian.type]];
    [namePrimeMeridians setObject:primeMeridian forKey:[primeMeridian.name lowercaseString]];

}

+(CRSPrimeMeridians *) eastWithType: (CRSPrimeMeridianType) type andName: (NSString *) name andDegree: (double) deg andMinute: (double) min andSecond: (double) sec{
    double longitude = ((sec / 60. + min) / 60. + deg) * (M_PI / 180.0);
    return [self createWithType:type andName:name andOffset:longitude];
}

+(CRSPrimeMeridians *) westWithType: (CRSPrimeMeridianType) type andName: (NSString *) name andDegree: (double) deg andMinute: (double) min andSecond: (double) sec{
    return [self eastWithType:type andName:name andDegree:-deg andMinute:-min andSecond:-sec];
}

+(CRSPrimeMeridians *) createWithType: (CRSPrimeMeridianType) type andName: (NSString *) name andOffset: (double) offsetFromGreenwich{
    return [[CRSPrimeMeridians alloc] initWithType:type andName:name andOffset:offsetFromGreenwich];
}

+(CRSPrimeMeridians *) fromType: (CRSPrimeMeridianType) type{
    return [typePrimeMeridians objectForKey:[NSNumber numberWithInt:type]];
}

+(CRSPrimeMeridians *) fromName: (NSString *) name{
    return [namePrimeMeridians objectForKey:[name lowercaseString]];
}

-(instancetype) initWithType: (CRSPrimeMeridianType) type andName: (NSString *) name andOffset: (double) offsetFromGreenwich{
    self = [super init];
    if(self != nil){
        _type = type;
        _name = name;
        _offsetFromGreenwich = offsetFromGreenwich;
    }
    return self;
}

-(CRSPrimeMeridianType) type{
    return _type;
}

-(NSString *) name{
    return _name;
}

-(double) offsetFromGreenwich{
    return _offsetFromGreenwich;
}

-(double) offsetFromGreenwichDegrees{
    return [CRSUnits convertValue:_offsetFromGreenwich fromUnit:[CRSUnits radian] toUnit:[CRSUnits degree]];
}

-(NSString *) description{
    return [NSString stringWithFormat:@"%@:%f", [self name], [self offsetFromGreenwich]];
}

-(BOOL) isEqual: (id) object{
    if(self == object){
        return YES;
    }
    
    if(![object isKindOfClass:[CRSPrimeMeridians class]]){
        return NO;
    }
    
    CRSPrimeMeridians *primeMeridian = (CRSPrimeMeridians *) object;
    if(_type != primeMeridian.type){
        return NO;
    }
    if(_name == nil){
        if (primeMeridian.name != nil){
            return NO;
        }
    }else if(![_name isEqualToString:primeMeridian.name]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_offsetFromGreenwich] isEqual:[NSNumber numberWithDouble:primeMeridian.offsetFromGreenwich]]){
        return NO;
    }
    return YES;
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    result = prime * result + [_name hash];
    result = prime * result + [[NSNumber numberWithDouble:_offsetFromGreenwich] hash];
    return result;
}

@end
