//
//  abc.h
//  iBus-iPhone
//
//  Created by yanghua on 5/26/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>



// table create sqls

//e.g:
/*
 清安线:
 //去程
 edgeStation_1:水阁路客运站
 edgeStation_2:安德门
 identifier:1   
 
 //回程
 edgeStation_1:安德门
 edgeStation_2:水阁路客运站
 identifier:2
 */
#define LINEINFO_CREATE_TABLE_SQL \
@"CREATE TABLE lineInfo (                       \
    lineId text,                                \
    lineName text,                              \
    edgeStation_1 text,                         \
    edgeStation_2 text,                         \
    identifier text,                            \
    identifier_1_favorite integer,              \
    identifier_2_favorite integer,              \
    identifier_1_schedule text,                 \
    identifier_2_schedule text                  \
)"

/*
 lineId                 - 线路编号
 lineName               - 线路名称
 edgeStation_1          - 一端站点
 edgeStation_2          - 另一端站点
 identifier             - 去程/回程标识 （默认全是1,即去程 ，2，表示回程）
 identifier_1_favorite  - 去程线路是否被收藏（1表示收藏，0表示未收藏）【业务无关】
 identifier_2_favorite  - 回程线路是否被收藏（1表示收藏，0表示未收藏）【业务无关】
 identifier_1_schedule  - 去程规划时间 "06:30-22:00"
 identifier_2_schedule  - 回程规划时间 "07:20-21:00"
 */


#define STATIONINFO_CREATE_TABLE_SQL \
@"CREATE TABLE stationInfo (                    \
    autoId integer PRIMARY KEY autoincrement,   \
    stationName text,                           \
    stationLog text,                            \
    stationLat text,                            \
    orderNo integer,                            \
    identifier_1_favorite integer,              \
    identifier_2_favorite integer,              \
    lineId text                                 \
)"

/*
 autoId                 - 自编号
 stationName            - 站点名称
 stationLog             - 经度(并不是所有的站点都有经纬度，有些没有的是0)
 stationLat             - 纬度(并不是所有的站点都有经纬度，有些没有的是0)
 orderNo                - 站点编号(默认是以去程来自增编号，即identifier为1)
 identifier_1_favorite  - 在去程线路上，该站点是否被收藏（1表示收藏，0表示未收藏）【业务无关】
 identifier_2_favorite  - 在回程线路上，该站点是否被收藏（1表示收藏，0表示未收藏）【业务无关】
 lineId                 - 线路编号
 */

#define CONFIGCATEGORY_CREATE_TABLE_SQL \
@"CREATE TABLE configCategory (                 \
    autoId integer PRIMARY KEY autoincrement,   \
    categoryId text,                            \
    categoryName text,                          \
    sectionNo integer                           \
)"

#define CONFIGITEM_CREATE_TABLE_SQL \
@"CREATE TABLE configItem (                     \
    autoId integer PRIMARY KEY autoincrement,   \
    itemKey text,                               \
    itemValue text,                             \
    categoryId text                             \
)"


#define CREATE_TABLE_SQL_ARRAY                  \
@[                                              \
    LINEINFO_CREATE_TABLE_SQL,                  \
    STATIONINFO_CREATE_TABLE_SQL,               \
    CONFIGCATEGORY_CREATE_TABLE_SQL,            \
    CONFIGITEM_CREATE_TABLE_SQL                 \
]