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

#define SELECT_ALL_LINEINFO_SQL \
@"SELECT * FROM lineInfo "

#define DELETE_LINEINFO_SQL \
@"DELETE FROM lineInfo WHERE lineId = ? "

#define DELETE_ALL_LINEINFO_SQL \
@"DELETE FROM lineInfo "

#define INSERT_LINEINFO_SQL \
@"INSERT INTO lineInfo(lineId,lineName,firstTime,lastTime,edgeStation_1,edgeStation_2,identifier) VALUES(:lineId,:lineName,:firstTime,:lastTime,:edgeStation_1,:edgeStation_2,:identifier)"

#define UPDATE_LINEINFO_SQL \
@"UPDATE lineInfo SET lineName = ? WHERE lineId = ?"

#define CHECK_EXISTS_LINEINFO_SQL \
@"SELECT COUNT(1) FROM lineInfo "


@interface LineDao : NSObject

+ (BOOL)checkIsInited;

+ (void)add:(NSMutableArray*)lineArray;

+ (void)remove:(NSMutableArray*)lineIdArray;

+ (void)removeAll;

+ (NSDictionary*)getLineInfoWithId:(NSString*)lineId;

+ (NSMutableArray*)getLineList;

@end
