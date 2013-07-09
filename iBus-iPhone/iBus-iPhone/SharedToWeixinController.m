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
    self.atBtn.hidden=YES;                              //hidden "@" button
	self.navigationItem.title=@"分享到微信";
    [WXApi registerApp:WX_AppID];
    [self registerWeixinCallbackNotification];
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
    if ([url.scheme isEqualToString:WX_AppID]) {
        [WXApi handleOpenURL:url delegate:self];
    }
}

#pragma mark - weixin delegate -
-(void) onResp:(BaseResp*)resp{
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        
        if (resp.errCode==0) {
            [SVProgressHUD showSuccessWithStatus:@"成功分享到微信!"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"分享到微信失败!"];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - publish base controller delegate -
- (void)publishBtn_handle:(id)sender{
    if (self.publishTxtView.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"还是说点什么吧"];
        return;
    }
    
    if (!([WXApi isWXAppInstalled]  && [WXApi isWXAppSupportApi]) ) {
        [SVProgressHUD showErrorWithStatus:@"当前系统中没有安装[微信]应用或微信版本不支持分享，请安装或升级[微信]!"];
        return;
    }
    
    ShareToWeixinOperation *operation=[[[ShareToWeixinOperation alloc]
                                           initOperationWithContent:self.publishTxtView.text
                                           andImageSupportSwitch:self.imageSwitch
                                            andScene:self.scene] autorelease];
    [((AppDelegate*)appDelegateObj).operationQueueCenter addOperation:operation];
}

- (void)atBtn_handle:(id)sender{
    
}


@end
