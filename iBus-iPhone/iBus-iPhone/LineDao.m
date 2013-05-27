//
//  LineDao.m
//  iBus-iPhone
//
//  Created by yanghua on 5/26/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineDao.h"

@implementation LineDao

#warning unImpl
+ (int)checkIsInited{
    
    return -1;
}

+ (void)add:(NSMutableArray*)lineArray{
    for (NSMutableDictionary *lineInfo in lineArray) {
        [LineDao addLineInfo:lineInfo];
    }
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
