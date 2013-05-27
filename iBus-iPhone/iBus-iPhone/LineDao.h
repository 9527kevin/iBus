//
//  LineDao.h
//  iBus-iPhone
//
//  Created by yanghua on 5/26/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECT_LINEINFO_SQL \
@"SELECT * FROM lineInfo WHERE lineId = ? "

#define DELETE_LINEINFO_SQL \
@"DELETE FROM lineInfo WHERE lineId = ? "

#define DELETE_ALL_LINEINFO_SQL \
@"DELETE FROM lineInfo "

#define INSERT_LINEINFO_SQL \
@"INSERT INTO lineInfo(lineId,lineName) VALUES(:lineId,:lineName)"

#define UPDATE_LINEINFO_SQL \
@"UPDATE lineInfo SET lineName = ? WHERE lineId = ?"


@interface LineDao : NSObject

+ (int)checkIsInited;

+ (void)add:(NSMutableArray*)lineArray;

+ (void)remove:(NSMutableArray*)lineIdArray;

+ (void)removeAll;

+ (void)modify:(NSMutableArray*)lineArray;

+ (NSMutableDictionary*)getLineInfoWithId:(NSString*)lineId;

@end
