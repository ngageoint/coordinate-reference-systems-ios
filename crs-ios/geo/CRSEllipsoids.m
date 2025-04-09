//
//  CRSEllipsoids.m
//  crs-ios
//
//  Created by Brian Osborn on 9/2/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSEllipsoids.h>

@interface CRSEllipsoids()

@property (nonatomic) CRSEllipsoidsType type;
@property (nonatomic, strong) NSMutableArray<NSString *> *names;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic) double equatorRadius;
@property (nonatomic) double poleRadius;
@property (nonatomic) double reciprocalFlattening;
@property (nonatomic) double eccentricity;
@property (nonatomic) double eccentricity2;

@end

@implementation CRSEllipsoids

/**
 * Type to Ellipsoid mapping
 */
static NSMutableDictionary<NSNumber *, CRSEllipsoids *> *typeEllipsoids = nil;

/**
 * Name and short name to Ellipsoid mapping
 */
static NSMutableDictionary<NSString *, CRSEllipsoids *> *nameEllipsoids = nil;

+(void) initialize{
    typeEllipsoids = [NSMutableDictionary dictionary];
    nameEllipsoids = [NSMutableDictionary dictionary];
 
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_INTERNATIONAL andShortName:@"intl" andEquatorRadius:6378388.0 andPoleRadius:0.0 andReciprocalFlattening:297.0 andNames:[NSArray arrayWithObjects:@"International 1909 (Hayford)", @"International 1924 (Hayford)", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_BESSEL andShortName:@"bessel" andEquatorRadius:6377397.155 andPoleRadius:0.0 andReciprocalFlattening:299.1528128 andName:@"Bessel 1841"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_CLARKE_1866 andShortName:@"clrk66" andEquatorRadius:6378206.4 andPoleRadius:6356583.8 andReciprocalFlattening:0.0 andName:@"Clarke 1866"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_CLARKE_1880 andShortName:@"clrk80" andEquatorRadius:6378249.145 andPoleRadius:0.0 andReciprocalFlattening:293.4663 andNames:[NSArray arrayWithObjects:@"Clarke 1880 mod.", @"Clarke 1880 (RGS)", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_AIRY andShortName:@"airy" andEquatorRadius:6377563.396 andPoleRadius:6356256.910 andReciprocalFlattening:0.0 andName:@"Airy 1830"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_WGS60 andShortName:@"WGS60" andEquatorRadius:6378165.0 andPoleRadius:0.0 andReciprocalFlattening:298.3 andName:@"WGS 60"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_WGS66 andShortName:@"WGS66" andEquatorRadius:6378145.0 andPoleRadius:0.0 andReciprocalFlattening:298.25 andNames:[NSArray arrayWithObjects:@"WGS 66", @"NWL 9D", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_WGS72 andShortName:@"WGS72" andEquatorRadius:6378135.0 andPoleRadius:0.0 andReciprocalFlattening:298.26 andName:@"WGS 72"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_WGS84 andShortName:@"WGS84" andEquatorRadius:6378137.0 andPoleRadius:0.0 andReciprocalFlattening:298.257223563 andName:@"WGS 84"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_KRASSOVSKY andShortName:@"krass" andEquatorRadius:6378245.0 andPoleRadius:0.0 andReciprocalFlattening:298.3 andNames:[NSArray arrayWithObjects:@"Krassovsky, 1942", @"Krassovsky 1942", @"Krassowsky 1940", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_EVEREST andShortName:@"evrst30" andEquatorRadius:6377276.345 andPoleRadius:0.0 andReciprocalFlattening:300.8017 andName:@"Everest 1830"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_INTERNATIONAL_1967 andShortName:@"new_intl" andEquatorRadius:6378157.5 andPoleRadius:6356772.2 andReciprocalFlattening:0.0 andName:@"New International 1967"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_GRS80 andShortName:@"GRS80" andEquatorRadius:6378137.0 andPoleRadius:0.0 andReciprocalFlattening:298.257222101 andName:@"GRS 1980 (IUGG, 1980)"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_AUSTRALIAN andShortName:@"australian" andEquatorRadius:6378160.0 andPoleRadius:6356774.7 andReciprocalFlattening:298.25 andName:@"Australian"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_MERIT andShortName:@"MERIT" andEquatorRadius:6378137.0 andPoleRadius:0.0 andReciprocalFlattening:298.257 andName:@"MERIT 1983"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_SGS85 andShortName:@"SGS85" andEquatorRadius:6378136.0 andPoleRadius:0.0 andReciprocalFlattening:298.257 andName:@"Soviet Geodetic System 85"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_IAU76 andShortName:@"IAU76" andEquatorRadius:6378140.0 andPoleRadius:0.0 andReciprocalFlattening:298.257 andName:@"IAU 1976"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_APL4_9 andShortName:@"APL4.9" andEquatorRadius:6378137.0 andPoleRadius:0.0 andReciprocalFlattening:298.25 andName:@"Appl. Physics. 1965"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_NWL9D andShortName:@"NWL9D" andEquatorRadius:6378145.0 andPoleRadius:0.0 andReciprocalFlattening:298.25 andName:@"Naval Weapons Lab., 1965"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_MOD_AIRY andShortName:@"mod_airy" andEquatorRadius:6377340.189 andPoleRadius:6356034.446 andReciprocalFlattening:0.0 andNames:[NSArray arrayWithObjects:@"Modified Airy", @"Airy Modified 1849", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_ANDRAE andShortName:@"andrae" andEquatorRadius:6377104.43 andPoleRadius:0.0 andReciprocalFlattening:300.0 andName:@"Andrae 1876 (Den., Iclnd.)"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_AUST_SA andShortName:@"aust_SA" andEquatorRadius:6378160.0 andPoleRadius:0.0 andReciprocalFlattening:298.25 andNames:[NSArray arrayWithObjects:@"Australian Natl & S. Amer. 1969", @"GRS 1967 Modified", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_GRS67 andShortName:@"GRS67" andEquatorRadius:6378160.0 andPoleRadius:0.0 andReciprocalFlattening:298.2471674270 andNames:[NSArray arrayWithObjects:@"GRS 67 (IUGG 1967)", @"GRS 1967", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_BESS_NAM andShortName:@"bess_nam" andEquatorRadius:6377483.865 andPoleRadius:0.0 andReciprocalFlattening:299.1528128 andNames:[NSArray arrayWithObjects:@"Bessel 1841 (Namibia)", @"Bessel Namibia (GLM)", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_CPM andShortName:@"CPM" andEquatorRadius:6375738.7 andPoleRadius:0.0 andReciprocalFlattening:334.29 andName:@"Comm. des Poids et Mesures 1799"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_DELMBR andShortName:@"delmbr" andEquatorRadius:6376428.0 andPoleRadius:0.0 andReciprocalFlattening:311.5 andName:@"Delambre 1810 (Belgium)"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_ENGELIS andShortName:@"engelis" andEquatorRadius:6378136.05 andPoleRadius:0.0 andReciprocalFlattening:298.2566 andName:@"Engelis 1985"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_EVRST48 andShortName:@"evrst48" andEquatorRadius:6377304.063 andPoleRadius:0.0 andReciprocalFlattening:300.8017 andName:@"Everest 1948"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_EVRST56 andShortName:@"evrst56" andEquatorRadius:6377301.243 andPoleRadius:0.0 andReciprocalFlattening:300.8017 andName:@"Everest 1956"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_EVRTS69 andShortName:@"evrst69" andEquatorRadius:6377295.664 andPoleRadius:0.0 andReciprocalFlattening:300.8017 andName:@"Everest 1969"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_EVRTSTSS andShortName:@"evrstSS" andEquatorRadius:6377298.556 andPoleRadius:0.0 andReciprocalFlattening:300.8017 andNames:[NSArray arrayWithObjects:@"Everest (Sabah & Sarawak)", @"Everest 1830 (1967 Definition)", nil]]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_FRSCH60 andShortName:@"fschr60" andEquatorRadius:6378166.0 andPoleRadius:0.0 andReciprocalFlattening:298.3 andName:@"Fischer (Mercury Datum) 1960"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_FSRCH60M andShortName:@"fschr60m" andEquatorRadius:6378155.0 andPoleRadius:0.0 andReciprocalFlattening:298.3 andName:@"Modified Fischer 1960"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_FSCHR68 andShortName:@"fschr68" andEquatorRadius:6378150.0 andPoleRadius:0.0 andReciprocalFlattening:298.3 andName:@"Fischer 1968"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_HELMERT andShortName:@"helmert" andEquatorRadius:6378200.0 andPoleRadius:0.0 andReciprocalFlattening:298.3 andName:@"Helmert 1906"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_HOUGH andShortName:@"hough" andEquatorRadius:6378270.0 andPoleRadius:0.0 andReciprocalFlattening:297.0 andName:@"Hough"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_KAULA andShortName:@"kaula" andEquatorRadius:6378163.0 andPoleRadius:0.0 andReciprocalFlattening:298.24 andName:@"Kaula 1961"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_LERCH andShortName:@"lerch" andEquatorRadius:6378139.0 andPoleRadius:0.0 andReciprocalFlattening:298.257 andName:@"Lerch 1979"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_MPRTS andShortName:@"mprts" andEquatorRadius:6397300.0 andPoleRadius:0.0 andReciprocalFlattening:191.0 andName:@"Maupertius 1738"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_PLESSIS andShortName:@"plessis" andEquatorRadius:6376523.0 andPoleRadius:6355863.0 andReciprocalFlattening:0.0 andName:@"Plessis 1817 (France)"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_SEASIA andShortName:@"SEasia" andEquatorRadius:6378155.0 andPoleRadius:6356773.3205 andReciprocalFlattening:0.0 andName:@"Southeast Asia"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_WALBECK andShortName:@"walbeck" andEquatorRadius:6376896.0 andPoleRadius:6355834.8467 andReciprocalFlattening:0.0 andName:@"Walbeck"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_NAD27 andShortName:@"NAD27" andEquatorRadius:6378249.145 andPoleRadius:0.0 andReciprocalFlattening:293.4663 andName:@"NAD27: Clarke 1880 mod."]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_NAD83 andShortName:@"NAD83" andEquatorRadius:6378137.0 andPoleRadius:0.0 andReciprocalFlattening:298.257222101 andName:@"NAD83: GRS 1980 (IUGG, 1980)"]];
    [self initializeEllipsoid:[self createWithType:CRS_ELLIPSOIDS_SPHERE andShortName:@"sphere" andEquatorRadius:6371008.7714 andPoleRadius:6371008.7714 andReciprocalFlattening:0.0 andName:@"Sphere"]];
    
}

+(void) initializeEllipsoid: (CRSEllipsoids *) ellipsoid{
    
    [typeEllipsoids setObject:ellipsoid forKey:[NSNumber numberWithInt:ellipsoid.type]];
    
    [nameEllipsoids setObject:ellipsoid forKey:[ellipsoid.shortName lowercaseString]];
    for(NSString *name in ellipsoid.names){
        NSString *lowercaseName = [name lowercaseString];
        if([nameEllipsoids objectForKey:lowercaseName] == nil){
            [nameEllipsoids setObject:ellipsoid forKey:lowercaseName];
        }
    }
}

+(CRSEllipsoids *) createWithType: (CRSEllipsoidsType) type andShortName: (NSString *) shortName andEquatorRadius: (double) equatorRadius andPoleRadius: (double) poleRadius andReciprocalFlattening: (double) reciprocalFlattening andName: (NSString *) name{
    return [[CRSEllipsoids alloc] initWithType:type andShortName:shortName andEquatorRadius:equatorRadius andPoleRadius:poleRadius andReciprocalFlattening:reciprocalFlattening andName:name];
}

+(CRSEllipsoids *) createWithType: (CRSEllipsoidsType) type andShortName: (NSString *) shortName andEquatorRadius: (double) equatorRadius andPoleRadius: (double) poleRadius andReciprocalFlattening: (double) reciprocalFlattening andNames: (NSArray<NSString *> *) names{
    return [[CRSEllipsoids alloc] initWithType:type andShortName:shortName andEquatorRadius:equatorRadius andPoleRadius:poleRadius andReciprocalFlattening:reciprocalFlattening andNames:names];
}

+(CRSEllipsoids *) fromType: (CRSEllipsoidsType) type{
    return [typeEllipsoids objectForKey:[NSNumber numberWithInt:type]];
}

+(CRSEllipsoids *) fromName: (NSString *) name{
    return [nameEllipsoids objectForKey:[name lowercaseString]];
}

-(instancetype) initWithType: (CRSEllipsoidsType) type andShortName: (NSString *) shortName andEquatorRadius: (double) equatorRadius andPoleRadius: (double) poleRadius andReciprocalFlattening: (double) reciprocalFlattening andName: (NSString *) name{
    return [self initWithType:type andShortName:shortName andEquatorRadius:equatorRadius andPoleRadius:poleRadius andReciprocalFlattening:reciprocalFlattening andNames:[NSArray arrayWithObject:name]];
}

-(instancetype) initWithType: (CRSEllipsoidsType) type andShortName: (NSString *) shortName andEquatorRadius: (double) equatorRadius andPoleRadius: (double) poleRadius andReciprocalFlattening: (double) reciprocalFlattening andNames: (NSArray<NSString *> *) names{
    self = [super init];
    if(self != nil){
        _type = type;
        _shortName = shortName;
        _names = [NSMutableArray array];
        _equatorRadius = equatorRadius;
        _poleRadius = poleRadius;
        _reciprocalFlattening = reciprocalFlattening;
        
        for(NSString *name in names) {
            NSRange range = [name rangeOfString:@"("];
            if(range.length > 0){
                [_names addObject:[[name substringToIndex:range.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            }
            [_names addObject:name];
        }
        
        if(poleRadius == 0.0 && reciprocalFlattening == 0.0){
            [NSException raise:@"Invalid Ellipsoid" format:@"One of poleRadius or reciprocalFlattening must be specified"];
        }

        if(reciprocalFlattening != 0){
            double flattening = 1.0 / reciprocalFlattening;
            double f = flattening;
            _eccentricity2 = 2 * f - f * f;
            _poleRadius = equatorRadius * sqrt(1.0 - _eccentricity2);
        } else {
            _eccentricity2 = 1.0 - (poleRadius * poleRadius)
                    / (equatorRadius * equatorRadius);
        }
        _eccentricity = sqrt(_eccentricity2);
    }
    return self;
}

-(CRSEllipsoidsType) type{
    return _type;
}

-(NSString *) name{
    return [_names firstObject];
}

-(NSArray<NSString *> *) names{
    return _names;
}

-(NSString *) shortName{
    return _shortName;
}

-(double) equatorRadius{
    return _equatorRadius;
}

-(double) reciprocalFlattening{
    return _reciprocalFlattening;
}

-(double) a{
    return _equatorRadius;
}

-(double) b{
    return _poleRadius;
}

-(void) setEccentricitySquared: (double) eccentricity2{
    _eccentricity2 = eccentricity2;
    _poleRadius = _equatorRadius * sqrt(1.0 - eccentricity2);
    _eccentricity = sqrt(eccentricity2);
}

-(double) eccentricitySquared{
    return _eccentricity2;
}

-(NSString *) description{
    return [self name];
}

-(BOOL) isEqual: (id) object{
    if(self == object){
        return YES;
    }
    
    if(![object isKindOfClass:[CRSEllipsoids class]]){
        return NO;
    }
    
    CRSEllipsoids *ellipsoid = (CRSEllipsoids *) object;
    if(_type != ellipsoid.type){
        return NO;
    }
    if(_names == nil){
        if(ellipsoid.names != nil){
            return NO;
        }
    }else if(![_names isEqual:ellipsoid.names]){
        return NO;
    }
    if(_shortName == nil){
        if (ellipsoid.shortName != nil){
            return NO;
        }
    }else if(![_shortName isEqualToString:ellipsoid.shortName]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_equatorRadius] isEqual:[NSNumber numberWithDouble:ellipsoid.equatorRadius]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_poleRadius] isEqual:[NSNumber numberWithDouble:ellipsoid.poleRadius]]){
        return NO;
    }
    if(![[NSNumber numberWithDouble:_eccentricity] isEqual:[NSNumber numberWithDouble:ellipsoid.eccentricity]]){
        return NO;
    }
    return YES;
}

-(NSUInteger) hash{
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [[NSNumber numberWithInt:_type] hash];
    result = prime * result + [_names hash];
    result = prime * result + [_shortName hash];
    result = prime * result + [[NSNumber numberWithDouble:_equatorRadius] hash];
    result = prime * result + [[NSNumber numberWithDouble:_poleRadius] hash];
    result = prime * result + [[NSNumber numberWithDouble:_eccentricity] hash];
    return result;
}

@end
