//
//  CRSAxisDirectionTypes.m
//  crs-ios
//
//  Created by Brian Osborn on 7/14/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSAxisDirectionTypes.h>

NSString * const CRS_AXIS_AFT_NAME = @"aft";
NSString * const CRS_AXIS_AWAY_FROM_NAME = @"awayFrom";
NSString * const CRS_AXIS_CLOCKWISE_NAME = @"clockwise";
NSString * const CRS_AXIS_COLUMN_NEGATIVE_NAME = @"columnNegative";
NSString * const CRS_AXIS_COLUMN_POSITIVE_NAME = @"columnPositive";
NSString * const CRS_AXIS_COUNTER_CLOCKWISE_NAME = @"counterClockwise";
NSString * const CRS_AXIS_DISPLAY_DOWN_NAME = @"displayDown";
NSString * const CRS_AXIS_DISPLAY_LEFT_NAME = @"displayLeft";
NSString * const CRS_AXIS_DISPLAY_RIGHT_NAME = @"displayRight";
NSString * const CRS_AXIS_DISPLAY_UP_NAME = @"displayUp";
NSString * const CRS_AXIS_DOWN_NAME = @"down";
NSString * const CRS_AXIS_EAST_NAME = @"east";
NSString * const CRS_AXIS_EAST_NORTH_EAST_NAME = @"eastNorthEast";
NSString * const CRS_AXIS_EAST_SOUTH_EAST_NAME = @"eastSouthEast";
NSString * const CRS_AXIS_FORWARD_NAME = @"forward";
NSString * const CRS_AXIS_FUTURE_NAME = @"future";
NSString * const CRS_AXIS_GEOCENTRIC_X_NAME = @"geocentricX";
NSString * const CRS_AXIS_GEOCENTRIC_Y_NAME = @"geocentricY";
NSString * const CRS_AXIS_GEOCENTRIC_Z_NAME = @"geocentricZ";
NSString * const CRS_AXIS_NORTH_NAME = @"north";
NSString * const CRS_AXIS_NORTH_EAST_NAME = @"northEast";
NSString * const CRS_AXIS_NORTH_NORTH_EAST_NAME = @"northNorthEast";
NSString * const CRS_AXIS_NORTH_NORTH_WEST_NAME = @"northNorthWest";
NSString * const CRS_AXIS_NORTH_WEST_NAME = @"northWest";
NSString * const CRS_AXIS_PAST_NAME = @"past";
NSString * const CRS_AXIS_PORT_NAME = @"port";
NSString * const CRS_AXIS_ROW_NEGATIVE_NAME = @"rowNegative";
NSString * const CRS_AXIS_ROW_POSITIVE_NAME = @"rowPositive";
NSString * const CRS_AXIS_SOUTH_NAME = @"south";
NSString * const CRS_AXIS_SOUTH_EAST_NAME = @"southEast";
NSString * const CRS_AXIS_SOUTH_SOUTH_EAST_NAME = @"southSouthEast";
NSString * const CRS_AXIS_SOUTH_SOUTH_WEST_NAME = @"southSouthWest";
NSString * const CRS_AXIS_SOUTH_WEST_NAME = @"southWest";
NSString * const CRS_AXIS_STARBOARD_NAME = @"starboard";
NSString * const CRS_AXIS_TOWARDS_NAME = @"towards";
NSString * const CRS_AXIS_UNSPECIFIED_NAME = @"unspecified";
NSString * const CRS_AXIS_UP_NAME = @"up";
NSString * const CRS_AXIS_WEST_NAME = @"west";
NSString * const CRS_AXIS_WEST_NORTH_WEST_NAME = @"westNorthWest";
NSString * const CRS_AXIS_WEST_SOUTH_WEST_NAME = @"westSouthWest";

@implementation CRSAxisDirectionTypes

+(NSString *) name: (CRSAxisDirectionType) type{
    NSString * name = nil;
    
    switch(type){
        case CRS_AXIS_AFT:
            name = CRS_AXIS_AFT_NAME;
            break;
        case CRS_AXIS_AWAY_FROM:
            name = CRS_AXIS_AWAY_FROM_NAME;
            break;
        case CRS_AXIS_CLOCKWISE:
            name = CRS_AXIS_CLOCKWISE_NAME;
            break;
        case CRS_AXIS_COLUMN_NEGATIVE:
            name = CRS_AXIS_COLUMN_NEGATIVE_NAME;
            break;
        case CRS_AXIS_COLUMN_POSITIVE:
            name = CRS_AXIS_COLUMN_POSITIVE_NAME;
            break;
        case CRS_AXIS_COUNTER_CLOCKWISE:
            name = CRS_AXIS_COUNTER_CLOCKWISE_NAME;
            break;
        case CRS_AXIS_DISPLAY_DOWN:
            name = CRS_AXIS_DISPLAY_DOWN_NAME;
            break;
        case CRS_AXIS_DISPLAY_LEFT:
            name = CRS_AXIS_DISPLAY_LEFT_NAME;
            break;
        case CRS_AXIS_DISPLAY_RIGHT:
            name = CRS_AXIS_DISPLAY_RIGHT_NAME;
            break;
        case CRS_AXIS_DISPLAY_UP:
            name = CRS_AXIS_DISPLAY_UP_NAME;
            break;
        case CRS_AXIS_DOWN:
            name = CRS_AXIS_DOWN_NAME;
            break;
        case CRS_AXIS_EAST:
            name = CRS_AXIS_EAST_NAME;
            break;
        case CRS_AXIS_EAST_NORTH_EAST:
            name = CRS_AXIS_EAST_NORTH_EAST_NAME;
            break;
        case CRS_AXIS_EAST_SOUTH_EAST:
            name = CRS_AXIS_EAST_SOUTH_EAST_NAME;
            break;
        case CRS_AXIS_FORWARD:
            name = CRS_AXIS_FORWARD_NAME;
            break;
        case CRS_AXIS_FUTURE:
            name = CRS_AXIS_FUTURE_NAME;
            break;
        case CRS_AXIS_GEOCENTRIC_X:
            name = CRS_AXIS_GEOCENTRIC_X_NAME;
            break;
        case CRS_AXIS_GEOCENTRIC_Y:
            name = CRS_AXIS_GEOCENTRIC_Y_NAME;
            break;
        case CRS_AXIS_GEOCENTRIC_Z:
            name = CRS_AXIS_GEOCENTRIC_Z_NAME;
            break;
        case CRS_AXIS_NORTH:
            name = CRS_AXIS_NORTH_NAME;
            break;
        case CRS_AXIS_NORTH_EAST:
            name = CRS_AXIS_NORTH_EAST_NAME;
            break;
        case CRS_AXIS_NORTH_NORTH_EAST:
            name = CRS_AXIS_NORTH_NORTH_EAST_NAME;
            break;
        case CRS_AXIS_NORTH_NORTH_WEST:
            name = CRS_AXIS_NORTH_NORTH_WEST_NAME;
            break;
        case CRS_AXIS_NORTH_WEST:
            name = CRS_AXIS_NORTH_WEST_NAME;
            break;
        case CRS_AXIS_PAST:
            name = CRS_AXIS_PAST_NAME;
            break;
        case CRS_AXIS_PORT:
            name = CRS_AXIS_PORT_NAME;
            break;
        case CRS_AXIS_ROW_NEGATIVE:
            name = CRS_AXIS_ROW_NEGATIVE_NAME;
            break;
        case CRS_AXIS_ROW_POSITIVE:
            name = CRS_AXIS_ROW_POSITIVE_NAME;
            break;
        case CRS_AXIS_SOUTH:
            name = CRS_AXIS_SOUTH_NAME;
            break;
        case CRS_AXIS_SOUTH_EAST:
            name = CRS_AXIS_SOUTH_EAST_NAME;
            break;
        case CRS_AXIS_SOUTH_SOUTH_EAST:
            name = CRS_AXIS_SOUTH_SOUTH_EAST_NAME;
            break;
        case CRS_AXIS_SOUTH_SOUTH_WEST:
            name = CRS_AXIS_SOUTH_SOUTH_WEST_NAME;
            break;
        case CRS_AXIS_SOUTH_WEST:
            name = CRS_AXIS_SOUTH_WEST_NAME;
            break;
        case CRS_AXIS_STARBOARD:
            name = CRS_AXIS_STARBOARD_NAME;
            break;
        case CRS_AXIS_TOWARDS:
            name = CRS_AXIS_TOWARDS_NAME;
            break;
        case CRS_AXIS_UNSPECIFIED:
            name = CRS_AXIS_UNSPECIFIED_NAME;
            break;
        case CRS_AXIS_UP:
            name = CRS_AXIS_UP_NAME;
            break;
        case CRS_AXIS_WEST:
            name = CRS_AXIS_WEST_NAME;
            break;
        case CRS_AXIS_WEST_NORTH_WEST:
            name = CRS_AXIS_WEST_NORTH_WEST_NAME;
            break;
        case CRS_AXIS_WEST_SOUTH_WEST:
            name = CRS_AXIS_WEST_SOUTH_WEST_NAME;
            break;
    }
    
    return name;
}

+(CRSAxisDirectionType) type: (NSString *) name{
    CRSAxisDirectionType value = -1;
    
    if(name != nil){
        name = [name uppercaseString];
        NSDictionary *types = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInteger:CRS_AXIS_AFT], [CRS_AXIS_AFT_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_AWAY_FROM], [CRS_AXIS_AWAY_FROM_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_CLOCKWISE], [CRS_AXIS_CLOCKWISE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_COLUMN_NEGATIVE], [CRS_AXIS_COLUMN_NEGATIVE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_COLUMN_POSITIVE], [CRS_AXIS_COLUMN_POSITIVE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_COUNTER_CLOCKWISE], [CRS_AXIS_COUNTER_CLOCKWISE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_DISPLAY_DOWN], [CRS_AXIS_DISPLAY_DOWN_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_DISPLAY_LEFT], [CRS_AXIS_DISPLAY_LEFT_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_DISPLAY_RIGHT], [CRS_AXIS_DISPLAY_RIGHT_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_DISPLAY_UP], [CRS_AXIS_DISPLAY_UP_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_DOWN], [CRS_AXIS_DOWN_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_EAST], [CRS_AXIS_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_EAST_NORTH_EAST], [CRS_AXIS_EAST_NORTH_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_EAST_SOUTH_EAST], [CRS_AXIS_EAST_SOUTH_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_FORWARD], [CRS_AXIS_FORWARD_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_FUTURE], [CRS_AXIS_FUTURE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_GEOCENTRIC_X], [CRS_AXIS_GEOCENTRIC_X_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_GEOCENTRIC_Y], [CRS_AXIS_GEOCENTRIC_Y_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_GEOCENTRIC_Z], [CRS_AXIS_GEOCENTRIC_Z_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_NORTH], [CRS_AXIS_NORTH_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_NORTH_EAST], [CRS_AXIS_NORTH_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_NORTH_NORTH_EAST], [CRS_AXIS_NORTH_NORTH_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_NORTH_NORTH_WEST], [CRS_AXIS_NORTH_NORTH_WEST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_NORTH_WEST], [CRS_AXIS_NORTH_WEST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_PAST], [CRS_AXIS_PAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_PORT], [CRS_AXIS_PORT_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_ROW_NEGATIVE], [CRS_AXIS_ROW_NEGATIVE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_ROW_POSITIVE], [CRS_AXIS_ROW_POSITIVE_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_SOUTH], [CRS_AXIS_SOUTH_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_SOUTH_EAST], [CRS_AXIS_SOUTH_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_SOUTH_SOUTH_EAST], [CRS_AXIS_SOUTH_SOUTH_EAST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_SOUTH_SOUTH_WEST], [CRS_AXIS_SOUTH_SOUTH_WEST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_SOUTH_WEST], [CRS_AXIS_SOUTH_WEST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_STARBOARD], [CRS_AXIS_STARBOARD_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_TOWARDS], [CRS_AXIS_TOWARDS_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_UNSPECIFIED], [CRS_AXIS_UNSPECIFIED_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_UP], [CRS_AXIS_UP_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_WEST], [CRS_AXIS_WEST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_WEST_NORTH_WEST], [CRS_AXIS_WEST_NORTH_WEST_NAME uppercaseString],
                               [NSNumber numberWithInteger:CRS_AXIS_WEST_SOUTH_WEST], [CRS_AXIS_WEST_SOUTH_WEST_NAME uppercaseString],
                               nil
                               ];
        NSNumber *enumValue = [types objectForKey:name];
        if(enumValue != nil){
            value = (CRSAxisDirectionType)[enumValue intValue];
        }
    }
    
    return value;
}

@end
