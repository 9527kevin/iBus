//
//  StationDao.h
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INSERT_STATIONINFO_SQL                                          \
@"INSERT INTO stationInfo(stationName,stationLog,stationLat,orderNo,lineId,identifier_1_favorite,identifier_2_favorite) VALUES(:stationName,:stationLog,:stationLat,:orderNo,:lineId:identifier_1_favorite,:identifier_2_favorite)"

#define CHECK_EXISTS_STATIONINFO_SQL                                    \
@"SELECT COUNT(1) FROM stationInfo "


#define SELECT_STATIONLIST_ORDER_ASC_SQL                                \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC"

#define SELECT_STATIONLIST_ORDER_DESC_SQL                               \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC"

#define SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_ASC_SQL                \
@"SELECT * FROM (                                                       \
       SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC  \
 ) WHERE orderno = ?"

#define SELECT_STATIONINFO_WITH_LINEID_AND_ORDER_DESC_SQL               \
@"SELECT * FROM (                                                       \
SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC        \
) WHERE orderno = ?"

#define SELECT_COUNT_STATION_WITH_LINEID                                \
@"SELECT COUNT(1) FROM stationInfo WHERE lineId = ?"

//favorite
#define UPDATE_STATION_FAVORITE_WITH_LINEID_ORDERNO_IDENTIFIER_1        \
@"UPDATE stationInfo SET identifier_1_favorite = ? WHERE stationName =  \
    (                                                                   \
    SELECT stationName FROM (                                           \
        SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC \
                    ) WHERE orderno = ?                                 \
    ) AND lineId = ?                                                    \
"

#define UPDATE_STATION_FAVORITE_WITH_LINEID_ORDERNO_IDENTIFIER_2        \
@"UPDATE stationInfo SET identifier_2_favorite = ? WHERE stationName =  \
    (                                                                   \
    SELECT stationName FROM (                                           \
        SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC\
                    ) WHERE orderno = ?                                 \
    ) AND lineId = ?                                                    \
"

#define CHECK_ISFAVORITE_IDENTIFIER_1                                   \
@"SELECT identifier_1_favorite FROM (                                   \
    SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC     \
) WHERE orderno = ?"

#define CHECK_ISFAVORITE_IDENTIFIER_2                                   \
@"SELECT identifier_2_favorite FROM (                                   \
    SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC    \
) WHERE orderno = ?"

#define SELECT_ALL_FAVORITES_STATIONINFO                                \
@"SELECT *,'identifier_1_favorite' as identifier_favorite               \
    FROM stationInfo WHERE identifier_1_favorite = 1                    \
UNION ALL                                                               \
SELECT *,'identifier_2_favorite' as identifier_favorite                 \
    FROM stationInfo WHERE identifier_2_favorite = 1"

//count : wheather in the middle or not
#define SELECT_COUNT_DYNAMIC_STATIONLIST_ORDER_ASC_SQL                  \
@"SELECT COUNT(1) FROM stationInfo WHERE lineId = ? AND orderno <= ?  ORDER BY orderno ASC "

#define SELECT_COUNT_DYNAMIC_STATIONLIST_ORDER_DESC_SQL                 \
@"SELECT COUNT(1) FROM stationInfo WHERE lineId = ? AND orderno >= ?  ORDER BY orderno DESC "

//in the middle
#define SELECT_DYNAMIC_STATIONLIST_ORDER_ASC_SQL                        \
@"SELECT * FROM stationInfo WHERE lineId = ? AND orderno <= ?  ORDER BY orderno ASC LIMIT 8 OFFSET ?"

#define SELECT_DYNAMIC_STATIONLIST_ORDER_DESC_SQL                       \
@"SELECT * FROM stationInfo WHERE lineId = ? AND orderno >= ? ORDER BY orderno DESC LIMIT 8  OFFSET ?"

//start or end
#define SELECT_DYNAMIC_STATIONLIST_ORDER_ASC_END_SQL                    \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno ASC LIMIT 8"

#define SELECT_DYNAMIC_STATIONLIST_ORDER_DESC_END_SQL                   \
@"SELECT * FROM stationInfo WHERE lineId = ? ORDER BY orderno DESC LIMIT 8"


@interface StationDao : NSObject

+ (BOOL)checkIsInited;

+ (void)add:(NSMutableArray*)stationList;

+ (NSMutableArray*)getStationListWithLineId:(NSString*)lineId
                              andIdentifier:(NSString*)identifier;

+ (NSMutableDictionary*)getStationInfoWithLineId:(NSString*)lineId
                                   andIdentifier:(NSString*)identifier
                                      andOrderNo:(NSNumber*)orderNo;

+ (NSMutableArray *)getDynamicStationList:(NSString*)lineId
                             andStationId:(NSNumber*)stationId
                            andIdentifier:(NSString*)identifier;

+ (int)getReverseStationNoWithLineId:(NSString*)lineId
                andOriginalStationId:(NSNumber*)stationId;

+ (void)favoriteWithLineId:(NSString*)lineId
             andIdentifier:(NSString*)identifier
                andOrderNo:(NSNumber*)orderNo;

+ (void)unfavoriteWithLineId:(NSString*)lineId
               andIdentifier:(NSString*)identifier
                  andOrderNo:(NSNumber*)orderNo;

+ (BOOL)isFavoriteWithLineId:(NSString*)lineId
               andIdentifier:(NSString*)identifier
                  andOrderNo:(NSNumber*)orderNo;

+ (NSMutableArray*)getAllFavorites;



@end
