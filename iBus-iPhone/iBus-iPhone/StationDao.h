//
//  StationDao.h
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INSERT_STATIONINFO_SQL \
@"INSERT INTO stationInfo(stationName,stationLog,stationLat,orderNo,lineId) VALUES(:stationName,:stationLog,:stationLat,:orderNo,:lineId)"

#define CHECK_EXISTS_STATIONINFO_SQL \
@"SELECT COUNT(1) FROM stationInfo "


#define SELECT_LINEINFO_ORDER_DESC_SQL \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC"

//#define SELECT_ALL_LINEINFO_SQL \
//@"SELECT * FROM stationInfo "


@interface StationDao : NSObject

+ (BOOL)checkIsInited;

+ (void)add:(NSMutableArray*)stationList;

+ (NSMutableArray*)getStationListWithLineId:(NSString*)lineId;

@end
