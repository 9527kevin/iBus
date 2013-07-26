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
    for (int i=335; i<=540; i++) {
        NSLog(@"*********************************%d**********************",i);
        NSMutableDictionary *lineInfo=[self getLineInfoWithLineId:
                                       [NSString stringWithFormat:@"%d",i]];
        lineInfo!=nil ? [lineInfoArray addObject:lineInfo] : nil;
        [NSThread sleepForTimeInterval:2.0f];
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
        
        if (responseDic[@"footer"] && [responseDic[@"footer"] count]>0 ) {
            //go schedule 
            if (responseDic[@"footer"][0][@"ofTime"] && responseDic[@"footer"][0][@"oeTime"]) {
                lineInfo[@"identifier_1_schedule"]=[NSString stringWithFormat:@"%@-%@",
                                                    responseDic[@"footer"][0][@"ofTime"],
                                                    responseDic[@"footer"][0][@"oeTime"]];
            }
            
            //back schedule
            if (responseDic[@"footer"][0][@"dfTime"] && responseDic[@"footer"][0][@"deTime"]) {
                lineInfo[@"identifier_2_schedule"]=[NSString stringWithFormat:@"%@-%@",
                                                    responseDic[@"footer"][0][@"dfTime"],
                                                    responseDic[@"footer"][0][@"deTime"]];
            }
        }
        
        lineInfo[@"edgeStation_1"]=responseDic[@"msgBean"][@"SStation"];
        lineInfo[@"edgeStation_2"]=responseDic[@"msgBean"][@"EStation"];
        lineInfo[@"identifier"]=@"1";
        lineInfo[@"identifier_1_favorite"]=[NSNumber numberWithInt:0];
        lineInfo[@"identifier_2_favorite"]=[NSNumber numberWithInt:0];
        
        
        lineInfo[@"identifier_1_schedule"]=(lineInfo[@"identifier_1_schedule"] !=nil) ?
                                            lineInfo[@"identifier_1_schedule"] :
                                            @"00:00-00:00";
        
        lineInfo[@"identifier_2_schedule"]=(lineInfo[@"identifier_2_schedule"] !=nil) ?
                                            lineInfo[@"identifier_2_schedule"] :
                                            @"00:00-00:00";
    }
    
    return lineInfo;
    
}

@end
