//
//  StationDao.m
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationDao.h"

@implementation StationDao

+ (void)add:(NSMutableArray*)lineArray{
    for (NSMutableDictionary *stationInfo in lineArray) {
        [StationDao addStationInfo:stationInfo];
    }
}

+ (BOOL)checkIsInited{
    __block int rowsCount=0;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:CHECK_EXISTS_STATIONINFO_SQL];
            if ([resultSet next]) {
                NSString *countStr=[resultSet stringForColumnIndex:0];
                if (countStr) {
                    rowsCount=[countStr intValue];
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return rowsCount!=0?YES:NO;
}

+ (NSMutableArray*)getStationListWithLineId:(NSString*)lineId andIdentifier:(NSString*)identifier{
    __block NSMutableArray *stationArray=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=nil;
            NSString *sql=[identifier isEqualToString:@"1"]?SELECT_STATIONLIST_ORDER_ASC_SQL:SELECT_STATIONLIST_ORDER_DESC_SQL;
            resultSet=[db executeQuery:sql,lineId];
            while ([resultSet next]) {
                [stationArray addObject:
                 @{
                 @"stationName": [resultSet stringForColumn:@"stationName"],
                 @"stationLog":[resultSet stringForColumn:@"stationLog"],
                 @"stationLat":[resultSet stringForColumn:@"stationLat"],
                 @"orderNo" : [resultSet stringForColumn:@"orderNo"],
                 @"lineId" : [resultSet stringForColumn:@"lineId"]
                 }];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return stationArray;
}

+ (NSDictionary*)getStationInfoWithLineId:(NSString*)lineId
                            andIdentifier:(NSString*)identifier
                               andOrderNo:(NSInteger)orderNo{
    __block NSDictionary *stationInfo=nil;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=nil;
            NSString *sql=[identifier isEqualToString:@"1"]?SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_ASC_SQL:SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_DESC_SQL;
            resultSet=[db executeQuery:sql,lineId,[NSString stringWithFormat:@"%d",orderNo]];
            if ([resultSet next]) {
                stationInfo= @{
                 @"stationName": [resultSet stringForColumn:@"stationName"],
                 @"stationLog":[resultSet stringForColumn:@"stationLog"],
                 @"stationLat":[resultSet stringForColumn:@"stationLat"],
                 @"orderNo" : [resultSet stringForColumn:@"orderNo"],
                 @"lineId" : [resultSet stringForColumn:@"lineId"]
                 };
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return stationInfo;
}

#pragma mark - inner methods -
+ (void)addStationInfo:(NSMutableDictionary*)stationInfo{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            [db executeUpdate:INSERT_STATIONINFO_SQL withParameterDictionary:stationInfo];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
}

@end
