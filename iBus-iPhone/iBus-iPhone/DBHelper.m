//
//  DBHelper.m
//  NanJingUniversity
//
//  Created by yanghua_kobe on 12/9/12.
//  Copyright (c) 2012 yanghua. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

static DBHelper *_dbHelperInstance;

+ (DBHelper*)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbHelperInstance=[[DBHelper alloc]init];
    });
    return _dbHelperInstance;
}

- (void)deleteDatabase:(NSString*)databasePath{
    if (fileExistsAtPath(databasePath)) {
        removerItemAtPath(databasePath);
    }
}

#pragma mark - private methods -
- (void)initWithCreatingTablesForDatabase:(NSString*)databasePath
                              andSQLArray:(NSArray*)sqlArr{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:databasePath];
    [dbQueue inDatabase:^(FMDatabase *db) {
        if (![db open]) {
            @throw [[[NSException alloc]initWithName:@"FMDatabase Error"
                                              reason:@"Can not open Database"
                                            userInfo:nil]autorelease];
        }
        
        for (NSString *createSQL in sqlArr) {
            [db executeUpdate:createSQL];
        }
        
        [db close];
    }];
}

@end
