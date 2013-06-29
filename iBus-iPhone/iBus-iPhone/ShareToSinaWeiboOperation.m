//
//  ShareToSinaWeiboOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 6/24/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareToSinaWeiboOperation.h"

#define API_statuses_update                 @"statuses/update.json"  //no image
#define API_statuses_upload                 @"statuses/upload.json"  //with image

@interface ShareToSinaWeiboOperation ()

@property (nonatomic,retain) SinaWeibo *sinaWeiboManager;

@end

@implementation ShareToSinaWeiboOperation

- (void)dealloc{
    [_sinaWeiboManager release],_sinaWeiboManager=nil;
    
    [super dealloc];
}

- (void)main{
    [self initSinaweiboManager];
    
    if (!self.sinaWeiboManager.isLoggedIn) {
        return;
    }
    
    [self.overlay postImmediateMessage:@"正分享到新浪微博..." animated:YES];
    
    NSMutableDictionary *requestParms=[NSMutableDictionary dictionary];
    requestParms[@"status"]=self.content;
    requestParms[@"access_token"]=self.sinaWeiboManager.accessToken;
        
    if (!self.imageSupportSwitch) {
        [self.sinaWeiboManager requestWithURL:API_statuses_update
                                       params:requestParms
                                   httpMethod:HTTP_METHOD_POST
                                     delegate:self];
    }else{
        requestParms[@"pic"]=[UIImage imageNamed:Resource_OF_AdImage];
        requestParms[@"status"]=[NSString stringWithFormat:@"%@ (请扫描大图)",self.content];
        [self.sinaWeiboManager requestWithURL:API_statuses_upload
                                       params:requestParms
                                   httpMethod:HTTP_METHOD_POST
                                     delegate:self];
    }
    
    //block current runloop!
    [super main];
}

- (void)initSinaweiboManager{
    _sinaWeiboManager=[[SinaWeibo alloc] initWithAppKey:kAppKey
                                              appSecret:kAppSecret
                                         appRedirectURI:kAppRedirectURI
                                            andDelegate:self];
    
    //exists login info
    NSDictionary *sinaweiboInfo = [UserDefault objectForKey:@"SinaWeiboAuthData"];
    if (sinaweiboInfo[@"AccessTokenKey"] && sinaweiboInfo[@"ExpirationDateKey"]
        && sinaweiboInfo[@"UserIDKey"])
    {
        self.sinaWeiboManager.accessToken = sinaweiboInfo[@"AccessTokenKey"];
        self.sinaWeiboManager.expirationDate = sinaweiboInfo[@"ExpirationDateKey"];
        self.sinaWeiboManager.userID = sinaweiboInfo[@"UserIDKey"];
    }
}

#pragma mark - SinaWeiboRequest Delegate -
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    if ([request.url hasSuffix:API_statuses_update]
        ||
        [request.url hasSuffix:API_statuses_upload]){           

        [GlobalInstance showOverlayErrorMsg:@"新浪微博发表失败!"
                                andDuration:2.0
                                 andOverlay:self.overlay];
        
        self.canceledAfterError=YES;
        [NSThread sleepForTimeInterval:5];
    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    if ([request.url hasSuffix:API_statuses_update]
        ||
        [request.url hasSuffix:API_statuses_upload]){
        
        [GlobalInstance showOverlayMsg:@"新浪微博发表成功!"
                           andDuration:2.0
                            andOverlay:self.overlay];
        
        self.completed=YES;
        [NSThread sleepForTimeInterval:5];
    }
    
}

@end
