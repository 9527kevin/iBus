//
//  LineDao.m
//  iBus-iPhone
//
//  Created by yanghua on 5/26/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineDao.h"

@implementation LineDao

+ (BOOL)checkIsInited{
    __block int rowsCount=0;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:CHECK_EXISTS_LINEINFO_SQL];
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

+ (void)add:(NSMutableArray*)lineArray{
    for (NSMutableDictionary *lineInfo in lineArray) {
        [LineDao addLineInfo:lineInfo];
    }
}

+ (NSDictionary*)getLineInfoWithId:(NSString*)lineId{
    __block NSDictionary *result=nil;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQueryWithFormat:SELECT_LINEINFO_SQL,lineId];
            if ([resultSet next]) {
                result=@{
                         @"lineId": [resultSet stringForColumn:@"lineId"],
                         @"lineName":[resultSet stringForColumn:@"lineName"],
                         @"firstTime":[resultSet stringForColumn:@"firstTime"],
                         @"lastTime" : [resultSet stringForColumn:@"lastTime"],
                         @"edgeStation_1":[resultSet stringForColumn:@"edgeStation_1"],
                         @"edgeStation_2":[resultSet stringForColumn:@"edgeStation_2"]
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
    
    return result;
}

+ (NSMutableArray*)getLineList{
    __block NSMutableArray *lineArray=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_ALL_LINEINFO_SQL];
            while ([resultSet next]) {
                [lineArray addObject:
                 @{
                 @"lineId": [resultSet stringForColumn:@"lineId"],
                 @"lineName":[resultSet stringForColumn:@"lineName"],
                 @"firstTime":[resultSet stringForColumn:@"firstTime"],
                 @"lastTime" : [resultSet stringForColumn:@"lastTime"],
                 @"edgeStation_1":[resultSet stringForColumn:@"edgeStation_1"],
                 @"edgeStation_2":[resultSet stringForColumn:@"edgeStation_2"]
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
    
    return lineArray;
}


#pragma mark - inner methods -
+ (void)addLineInfo:(NSMutableDictionary*)lineInfo{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            [db executeUpdate:INSERT_LINEINFO_SQL withParameterDictionary:lineInfo];
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
