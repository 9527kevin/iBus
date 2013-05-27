//
//  LineDao.m
//  iBus-iPhone
//
//  Created by yanghua on 5/26/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineDao.h"

@implementation LineDao

+ (void)add:(NSMutableArray*)lineArray{
    for (NSMutableDictionary *lineInfo in lineArray) {
        
    }
}




#pragma mark - inner methods -
+ (void)addLineInfo:(NSMutableDictionary*)lineInfo{
    FMDatabaseQueue *dbQueue=[FMDatabaseQueue databaseQueueWithPath:[UserDefault objectForKey:@"privateDBPath"]];
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
