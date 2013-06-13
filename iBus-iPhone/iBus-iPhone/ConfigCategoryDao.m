//
//  ConfigCategoryDao.m
//  iBus-iPhone
//
//  Created by yanghua on 6/13/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ConfigCategoryDao.h"

@implementation ConfigCategoryDao

+ (NSMutableArray*)getAll{
    __block NSMutableArray *categoryArr=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_ALLCONFIGCATEGORY];
            while ([resultSet next]) {
                [categoryArr addObject:@{
                 @"categoryId" : [resultSet stringForColumn:@"categoryId"],
                 @"categoryName" : [resultSet stringForColumn:@"categoryName"],
                 @"sectionNo" : [NSNumber numberWithInt:[resultSet intForColumn:@"sectionNo"]]
                 }
                 ];
                
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return categoryArr;
}

+ (NSMutableArray*)getCategory:(NSString*)sectionNo{
    __block NSMutableArray *categoryArr=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_CONFIGCATEGORY_BY_SECTIONNO,sectionNo];
            while ([resultSet next]) {
                [categoryArr addObject:@{
                 @"categoryId" : [resultSet stringForColumn:@"categoryId"],
                 @"categoryName" : [resultSet stringForColumn:@"categoryName"],
                 @"sectionNo" : [NSNumber numberWithInt:[resultSet intForColumn:@"sectionNo"]]
                 }
                 ];
            
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return categoryArr;
}

+ (void)add:(NSMutableDictionary*)configCategory{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            [db executeUpdate:INSERT_CONFIGCATEGORY
      withParameterDictionary:configCategory];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
}

+ (BOOL)checkIsInited{
    __block int rowsCount=0;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:CHECK_EXISTS_CONFIGCATEGORY_SQL];
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

@end
