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

//+ (NSDictionary*)getStationInfoWithLineId:(NSString*)lineId{
//    __block NSDictionary *result=nil;
//    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
//    [dbQueue inDatabase:^(FMDatabase *db) {
//        @try {
//            FMResultSet *resultSet=[db executeQueryWithFormat:SELECT_LINEINFO_ORDER_DESC_SQL,lineId];
//            if ([resultSet next]) {
//                result=@{
//                         @"stationName": [resultSet stringForColumn:@"stationName"],
//                         @"stationLog":[resultSet stringForColumn:@"stationLog"],
//                         @"stationLat":[resultSet stringForColumn:@"stationLat"],
//                         @"orderNo" : [resultSet stringForColumn:@"orderNo"],
//                         @"lineId" : [resultSet stringForColumn:@"lineId"]
//                         };
//            }
//        }
//        @catch (NSException *exception) {
//            NSLog(@"%@",[exception reason]);
//        }
//        @finally {
//            [db close];
//        }
//    }];
//    
//    return result;
//}

+ (NSMutableArray*)getStationListWithLineId:(NSString*)lineId{
    __block NSMutableArray *stationArray=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_LINEINFO_ORDER_DESC_SQL,lineId];
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
