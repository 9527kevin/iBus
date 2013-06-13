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
 //顺序方向
 edgeStation_1:水阁路客运站
 edgeStation_2:安德门
 identifier:1   
 
 //逆序方向
 edgeStation_1:安德门
 edgeStation_2:水阁路客运站
 identifier:2
 */
#define LINEINFO_CREATE_TABLE_SQL \
@"CREATE TABLE lineInfo (   \
    lineId text,            \
    lineName text,          \
    firstTime text,         \
    lastTime text,          \
    edgeStation_1 text,     \
    edgeStation_2 text,     \
    identifier text         \
)"

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

//LINEINFO_CREATE_TABLE_SQL,                    \
STATIONINFO_CREATE_TABLE_SQL                    \
CONFIGCATEGORY_CREATE_TABLE_SQL,                \

#define CREATE_TABLE_SQL_ARRAY                  \
@[                                              \
    CONFIGITEM_CREATE_TABLE_SQL                 \
]