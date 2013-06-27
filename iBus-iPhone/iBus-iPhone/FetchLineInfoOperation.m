//
//  FetchLineInfoOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 5/27/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "FetchLineInfoOperation.h"
#import "LineDao.h"

@implementation FetchLineInfoOperation

- (void)main{
    [super main];
    
    NSMutableArray *lineInfoArray=[NSMutableArray array];
    
    //send request to fetch line info
    for (int i=335; i<=530; i++) {
        NSMutableDictionary *lineInfo=[self getLineInfoWithLineId:[NSString stringWithFormat:@"%d",i]];
        lineInfo!=nil ? [lineInfoArray addObject:lineInfo] : nil;
    }
    
    //insert into db
    [LineDao add:lineInfoArray];
}


- (NSMutableDictionary*)getLineInfoWithLineId:(NSString*)lineId{
    NSString *urlStr=[NSString stringWithFormat:Url_DetailOfLine,lineId];
    NSURL *requestUrl=[NSURL URLWithString:urlStr];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:requestUrl];
    [request startSynchronous];
    NSData *responseData=[request responseData];
    NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseData
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
    
    NSMutableDictionary *lineInfo=nil;
    if ([responseDic[@"success"] boolValue]==YES) {
        lineInfo=[NSMutableDictionary dictionary];
        lineInfo[@"lineId"]=responseDic[@"msgBean"][@"id"];
        lineInfo[@"lineName"]=responseDic[@"msgBean"][@"text"];
        
        if (responseDic[@"footer"] && [responseDic[@"footer"] count]>0 && responseDic[@"footer"][0][@"ofTime"]) {
            lineInfo[@"firstTime"]=responseDic[@"footer"][0][@"ofTime"];
        }
        
        if (responseDic[@"footer"] && [responseDic[@"footer"] count]>0 && responseDic[@"footer"][0][@"oeTime"]) {
            lineInfo[@"lastTime"]=responseDic[@"footer"][0][@"oeTime"];
        }
        
        lineInfo[@"edgeStation_1"]=responseDic[@"msgBean"][@"SStation"];
        lineInfo[@"edgeStation_2"]=responseDic[@"msgBean"][@"EStation"];
        lineInfo[@"identifier"]=@"1";
        lineInfo[@"identifier_1_favorite"]=[NSNumber numberWithInt:0];
        lineInfo[@"identifier_2_favorite"]=[NSNumber numberWithInt:0];
    }
    
    return lineInfo;
    
}

@end
