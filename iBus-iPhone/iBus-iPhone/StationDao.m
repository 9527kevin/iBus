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

+ (NSMutableArray*)getStationListWithLineId:(NSString*)lineId
                              andIdentifier:(NSString*)identifier{
    __block NSMutableArray *stationArray=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=nil;
            NSString *sql=[identifier isEqualToString:@"1"]?SELECT_STATIONLIST_ORDER_ASC_SQL:SELECT_STATIONLIST_ORDER_DESC_SQL;
            resultSet=[db executeQuery:sql,lineId];
            while ([resultSet next]) {
                [stationArray addObject:[NSMutableDictionary dictionaryWithDictionary:
                 @{
                 @"stationName": [resultSet stringForColumn:@"stationName"],
                 @"stationLog":[resultSet stringForColumn:@"stationLog"],
                 @"stationLat":[resultSet stringForColumn:@"stationLat"],
                 @"orderNo" : [resultSet stringForColumn:@"orderNo"],
                 @"lineId" : [resultSet stringForColumn:@"lineId"],
                 @"identifier" : identifier,
                 @"identifier_1_favorite":[resultSet stringForColumn:@"identifier_1_favorite"],
                 @"identifier_2_favorite":[resultSet stringForColumn:@"identifier_2_favorite"]
                 }]];
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

+ (NSMutableDictionary*)getStationInfoWithLineId:(NSString*)lineId
                                   andIdentifier:(NSString*)identifier
                                      andOrderNo:(NSNumber*)orderNo{
    __block NSDictionary *stationInfo=nil;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=nil;
            NSString *sql=[identifier isEqualToString:@"1"]?SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_ASC_SQL:SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_DESC_SQL;
            resultSet=[db executeQuery:sql,lineId,orderNo];
            if ([resultSet next]) {
                stationInfo= @{
                 @"stationName": [resultSet stringForColumn:@"stationName"],
                 @"stationLog":[resultSet stringForColumn:@"stationLog"],
                 @"stationLat":[resultSet stringForColumn:@"stationLat"],
                 @"orderNo" : [resultSet stringForColumn:@"orderNo"],
                 @"lineId" : [resultSet stringForColumn:@"lineId"],
                 @"identifier" : identifier,
                 @"identifier_1_favorite":[resultSet stringForColumn:@"identifier_1_favorite"],
                 @"identifier_2_favorite":[resultSet stringForColumn:@"identifier_2_favorite"]
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
    
    return [NSMutableDictionary dictionaryWithDictionary:stationInfo];
}

+ (NSMutableArray *)getDynamicStationList:(NSString*)lineId
                             andStationId:(NSNumber*)stationId
                            andIdentifier:(NSString*)identifier{
    __block NSMutableArray *stationArray=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=nil;
            int itemCount=0;
            
            //judge
            BOOL isMiddle=YES;
            NSString *sql=[identifier isEqualToString:@"1"]?SELECT_COUNT_DYNAMIC_STATIONLIST_ORDER_ASC_SQL:SELECT_COUNT_DYNAMIC_STATIONLIST_ORDER_DESC_SQL;
            resultSet=[db executeQuery:sql,lineId,stationId];
            if ([resultSet next]) {
                isMiddle=[resultSet intForColumnIndex:0]>=Dynamic_Station_List_Count?YES:NO;
                itemCount=[resultSet intForColumnIndex:0];
            }
            
            if (isMiddle) {         //in the middle
                NSNumber *offset ;
                if ([identifier isEqualToString:@"1"]) {            //order by asc
                    offset = [NSNumber numberWithInt:[stationId intValue] - 8];
                }else{                                              //order by desc
                    offset = [NSNumber numberWithInt:itemCount - 8];
                }
                
                sql=[identifier isEqualToString:@"1"]?SELECT_DYNAMIC_STATIONLIST_ORDER_ASC_SQL:SELECT_DYNAMIC_STATIONLIST_ORDER_DESC_SQL;
                resultSet=[db executeQuery:sql,lineId,stationId,offset];
            }else{                  //start or end
                sql=[identifier isEqualToString:@"1"]?SELECT_DYNAMIC_STATIONLIST_ORDER_ASC_END_SQL:SELECT_DYNAMIC_STATIONLIST_ORDER_DESC_END_SQL;
                resultSet=[db executeQuery:sql,lineId,stationId];
            }
            
            while ([resultSet next]) {
                [stationArray addObject:[NSMutableDictionary dictionaryWithDictionary:
                                         @{
                                         @"stationName": [resultSet stringForColumn:@"stationName"],
                                         @"stationLog":[resultSet stringForColumn:@"stationLog"],
                                         @"stationLat":[resultSet stringForColumn:@"stationLat"],
                                         @"orderNo" : [resultSet stringForColumn:@"orderNo"],
                                         @"lineId" : [resultSet stringForColumn:@"lineId"]
                                         }]];
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

/*
 * reverse station no, if count is 30 , stationId :28 then return 3 (30 + 1 - 28)
 */
+ (int)getReverseStationNoWithLineId:(NSString*)lineId
                andOriginalStationId:(NSNumber*)stationId{
    if (!lineId || [lineId isEqualToString:@""]) {
        return -1;
    }
    
    __block int rowsCount=0;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_COUNT_STATION_WITH_LINEID,lineId];
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
    
    return rowsCount + 1 - [stationId intValue];
}

+ (void)favoriteWithLineId:(NSString*)lineId
             andIdentifier:(NSString*)identifier
                andOrderNo:(NSNumber*)orderNo{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            NSString *sql=[identifier isEqualToString:@"1"] ?
            UPDATE_STATION_FAVORITE_WITH_LINEID_ORDERNO_IDENTIFIER_1 :
            UPDATE_STATION_FAVORITE_WITH_LINEID_ORDERNO_IDENTIFIER_2;
            [db executeUpdate:sql,[NSNumber numberWithInt:1],lineId,orderNo,lineId];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
}

+ (void)unfavoriteWithLineId:(NSString*)lineId
               andIdentifier:(NSString*)identifier
                  andOrderNo:(NSNumber*)orderNo{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            NSString *sql=[identifier isEqualToString:@"1"] ?
            UPDATE_STATION_FAVORITE_WITH_LINEID_ORDERNO_IDENTIFIER_1 :
            UPDATE_STATION_FAVORITE_WITH_LINEID_ORDERNO_IDENTIFIER_2;
            [db executeUpdate:sql,[NSNumber numberWithInt:0],lineId,orderNo,lineId];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
}

+ (BOOL)isFavoriteWithLineId:(NSString*)lineId
               andIdentifier:(NSString*)identifier
                  andOrderNo:(NSNumber*)orderNo{
    __block int isFavorite=NO;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            NSString *sql=([identifier isEqualToString:@"1"]) ?
            CHECK_ISFAVORITE_IDENTIFIER_1 :
            CHECK_ISFAVORITE_IDENTIFIER_2;
                        
            FMResultSet *resultSet=[db executeQuery:sql,lineId,orderNo];
            if ([resultSet next]) {
                isFavorite=[resultSet boolForColumnIndex:0];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return (isFavorite==0)?NO:YES;
}

+ (NSMutableArray*)getAllFavorites{
    __block NSMutableArray *stationArray=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=nil;
            resultSet=[db executeQuery:SELECT_ALL_FAVORITES_STATIONINFO];
            while ([resultSet next]) {
                [stationArray addObject:[NSMutableDictionary dictionaryWithDictionary:
                                         @{
                                         @"stationName": [resultSet stringForColumn:@"stationName"],
                                         @"stationLog":[resultSet stringForColumn:@"stationLog"],
                                         @"stationLat":[resultSet stringForColumn:@"stationLat"],
                                         @"orderNo" : [resultSet stringForColumn:@"orderNo"],
                                         @"lineId" : [resultSet stringForColumn:@"lineId"],
                                         @"identifier_1_favorite":[resultSet stringForColumn:@"identifier_1_favorite"],
                                         @"identifier_2_favorite":[resultSet stringForColumn:@"identifier_2_favorite"],
                                         @"identifier_favorite":[resultSet stringForColumn:@"identifier_favorite"]
                                         }]];
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
