//
//  FetchStationInfoOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "FetchStationInfoOperation.h"
#import "StationDao.h"

@implementation FetchStationInfoOperation

- (void)main{
    [super main];
    
    //send request to fetch line info and insert into db
    for (int i=335; i<=530; i++) {
        NSMutableArray *stationListOfLine=[self getStationListWithLineId:[NSString stringWithFormat:@"%d",i]];
        [StationDao add:stationListOfLine];
    }
    
}

- (NSMutableArray*)getStationListWithLineId:(NSString*)lineId{
    NSString *urlStr=[NSString stringWithFormat:Url_DetailOfLine,lineId];
    NSURL *requestUrl=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:requestUrl];
    [request startSynchronous];
    NSData *responseData=[request responseData];
    NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseData
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
    
    NSMutableArray *stationList=[NSMutableArray array];
    
    NSMutableDictionary *stationInfo=nil;
    if ([responseDic[@"success"] boolValue]==YES && [responseDic[@"rows"] count]>0) {
        NSArray *stationJsonArr=responseDic[@"rows"];
        for (NSDictionary *item in stationJsonArr) {
            stationInfo=[NSMutableDictionary dictionary];
            stationInfo[@"stationName"]=item[@"text"];
            stationInfo[@"stationLog"]=item[@"log"];
            stationInfo[@"stationLat"]=item[@"lat"];
            stationInfo[@"orderNo"]=item[@"id"];
            stationInfo[@"lineId"]=responseDic[@"msgBean"][@"id"];
            stationInfo[@"identifier_1_favorite"]=[NSNumber numberWithInt:0];
            stationInfo[@"identifier_2_favorite"]=[NSNumber numberWithInt:0];
            [stationList addObject:stationInfo];
        }
        
    }
    
    return stationList;
    
}

@end
