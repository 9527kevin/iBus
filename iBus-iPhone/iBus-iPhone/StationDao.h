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


#define SELECT_STATIONLIST_ORDER_ASC_SQL \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC"

#define SELECT_STATIONLIST_ORDER_DESC_SQL \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC"

#define SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_ASC_SQL \
@"SELECT * FROM (               \
       SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC \
 ) WHERE orderno = ?"

#define SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_DESC_SQL \
@"SELECT * FROM (               \
SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC \
) WHERE orderno = ?"



@interface StationDao : NSObject

+ (BOOL)checkIsInited;

+ (void)add:(NSMutableArray*)stationList;

+ (NSMutableArray*)getStationListWithLineId:(NSString*)lineId
                              andIdentifier:(NSString*)identifier;

+ (NSMutableDictionary*)getStationInfoWithLineId:(NSString*)lineId
                                   andIdentifier:(NSString*)identifier
                                      andOrderNo:(NSInteger)orderNo;

@end
