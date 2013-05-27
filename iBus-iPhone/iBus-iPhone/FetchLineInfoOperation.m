//
//  FetchLineInfoOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 5/27/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "FetchLineInfoOperation.h"

@implementation FetchLineInfoOperation

- (void)main{
    [super main];
    
    NSMutableArray *lineInfoArray=[NSMutableArray array];
    
    //send request to fetch line info
//    for (int i=0; i<100; i++) {
//        NSMutableDictionary *lineInfo=[self getLineInfoWithLineId:[NSString stringWithFormat:@"%d",i]];
//        NSLog(@"%@",lineInfo[@"lineId"]);
//        NSLog(@"%@",lineInfo[@"lineName"]);
//        [lineInfoArray addObject:lineInfo];
//    }
    
    NSMutableDictionary *lineInfo=[self getLineInfoWithLineId:@"400"];
    NSLog(@"%@",lineInfo[@"lineId"]);
    NSLog(@"%@",lineInfo[@"lineName"]);
    
    //send a message to message center
    
    
    
}


- (NSMutableDictionary*)getLineInfoWithLineId:(NSString*)lineId{
    NSString *urlStr=[NSString stringWithFormat:@"http://112.2.33.3:7106/BusAndroid/android.do?command=toLs&lineId=%@&inDown=1",lineId];
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
    }
    
    return lineInfo;
    
}

@end
