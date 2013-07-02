//
//  SharedToWeixinController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/21/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SharedToWeixinController.h"
#import "ShareToWeixinOperation.h"

@interface SharedToWeixinController ()

@end

@implementation SharedToWeixinController

- (void)dealloc{
    [Default_Notification_Center removeObserver:self
                                           name:Notification_For_URL_Scheme
                                         object:nil];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    super.delegate=self;
    [super viewDidLoad];
	self.navigationItem.title=@"分享到微信";
    [WXApi registerApp:WX_AppID];
    [self registerWeixinCallbackNotification];
    [self authorize];                               //request for authorizing!
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)registerWeixinCallbackNotification{
    [Default_Notification_Center addObserver:self
                                    selector:@selector(handleWeixinCallbackNotification:)
                                        name:Notification_For_URL_Scheme
                                      object:nil];
}

- (void)handleWeixinCallbackNotification:(NSNotification*)notification{
    NSURL *url=(NSURL*)[notification object];
    [WXApi handleOpenURL:url delegate:self];
}

- (void)authorize{
    SendAuthReq* req = [[[SendAuthReq alloc] init] autorelease];
    req.scope = @"post_timeline";
    req.state = @"iBus-iPhone";
    
    [WXApi sendReq:req];
}

#pragma mark - weixin delegate -
-(void) onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendAuthResp class]]){
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        switch (resp.errCode) {
            case 0:                                         //success
                [SVProgressHUD showSuccessWithStatus:@"授权成功!"];
                break;
                
            default:
                [SVProgressHUD showErrorWithStatus:@"授权失败!"];
                break;
        }
        
    }
}

-(void) onSentAuthRequest:(NSString *)userName
              accessToken:(NSString *)token
               expireDate:(NSDate *)expireDate
                 errorMsg:(NSString *)errMsg{
    NSLog(@"%@",errMsg);
}

#pragma mark - publish base controller delegate -
- (void)publishBtn_handle:(id)sender{
    if (self.publishTxtView.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"还是说点什么吧"];
        return;
    }
    
    ShareToWeixinOperation *operation=[[[ShareToWeixinOperation alloc]
                                           initOperationWithContent:self.publishTxtView.text
                                           andImageSupportSwitch:self.imageSwitch] autorelease];
    [((AppDelegate*)appDelegateObj).operationQueueCenter addOperation:operation];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)atBtn_handle:(id)sender{
    
}


@end
