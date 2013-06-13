//
//  ConfigItemDao.m
//  iBus-iPhone
//
//  Created by yanghua on 6/13/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ConfigItemDao.h"

@implementation ConfigItemDao

+ (NSMutableArray*)getItemWithCategoryId:(NSString*)categoryId{
    __block NSMutableArray *itemArr=[NSMutableArray array];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_CONFIGITEM_BY_CATEGORYID,categoryId];
            while ([resultSet next]) {
                [itemArr addObject:@{
                        [resultSet stringForColumn:@"itemKey"]:
                        [resultSet stringForColumn:@"itemValue"]
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
    
    return itemArr;
}

+ (NSMutableDictionary*)get:(NSString*)key{
    __block NSMutableDictionary *itemDic=[NSMutableDictionary dictionary];
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:SELECT_CONFIGITEM_BY_CATEGORYID,key];
            if ([resultSet next]) {
                itemDic[[resultSet stringForColumn:@"itemKey"]]=[resultSet stringForColumn:@"itemValue"];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
    
    return itemDic;
}

+ (void)set:(NSMutableDictionary*)configItem{
    BOOL isExist=[self checkExistsWithKey:configItem[@"itemKey"]];
    if (isExist) {
        FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
        [dbQueue inDatabase:^(FMDatabase *db) {
            @try {
                [db executeUpdate:UPDATE_CONFIGITEM_BY_ITEMKEY
          withParameterDictionary:configItem];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",[exception reason]);
            }
            @finally {
                [db close];
            }
        }];
    }else{
        [self add:configItem];
    }
}

+ (void)add:(NSMutableDictionary*)configItem{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            [db executeUpdate:INSERT_CONFIGITEM withParameterDictionary:configItem];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception reason]);
        }
        @finally {
            [db close];
        }
    }];
}

+ (void)removeByItemKey:(NSString*)key{
    
}

#pragma mark - private methods -
+ (BOOL)checkExistsWithKey:(NSString*)key{
    __block int rowsCount=0;
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:PATH_OF_DB];
    [dbQueue inDatabase:^(FMDatabase *db) {
        @try {
            FMResultSet *resultSet=[db executeQuery:CHECK_CONFIGITEM_EXISTS,key];
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
