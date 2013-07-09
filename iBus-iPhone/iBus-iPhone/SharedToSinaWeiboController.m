//
//  SharedToSinaWeiboControllerViewController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/21/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SharedToSinaWeiboController.h"
#import "ShareToSinaWeiboOperation.h"
#import "FollowedSinaweiboController.h"

@interface SharedToSinaWeiboController ()

@property (nonatomic,retain) SinaWeibo *sinaWeiboManager;

@end

@implementation SharedToSinaWeiboController

- (void)dealloc{
    [_sinaWeiboManager release],_sinaWeiboManager=nil;
    [Default_Notification_Center removeObserver:self
                                           name:Notification_For_URL_Scheme
                                         object:nil];
    
    [super dealloc];
}


- (void)viewDidLoad
{
    super.delegate=self;
    [super viewDidLoad];
    self.navigationItem.title=@"分享到新浪微博";
	[self initSinaweiboManager];
    [self registerSSOCallbackNotification];
    
    if (![self isAuthorized]) {
        [self login];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - super class's public methods -
- (BOOL)isAuthorized{
    return self.sinaWeiboManager.isAuthValid;
}

- (void)login{
    [self.sinaWeiboManager logIn];
}

- (void)logout{
    [self.sinaWeiboManager logOut];
}

- (void)share{
    
}

#pragma mark - private methods -
- (void)initSinaweiboManager{
    _sinaWeiboManager=[[SinaWeibo alloc] initWithAppKey:kAppKey
                                               appSecret:kAppSecret
                                          appRedirectURI:kAppRedirectURI
                                             andDelegate:self];
    self.sinaWeiboManager.ssoCallbackScheme=URL_OF_SHEME;
    
    //exists login info
    NSDictionary *sinaweiboInfo=[UserDefault objectForKey:@"SinaWeiboAuthData"];
    if (sinaweiboInfo[@"AccessTokenKey"] && sinaweiboInfo[@"ExpirationDateKey"]
                                        && sinaweiboInfo[@"UserIDKey"])
    {
        self.sinaWeiboManager.accessToken = sinaweiboInfo[@"AccessTokenKey"];
        self.sinaWeiboManager.expirationDate = sinaweiboInfo[@"ExpirationDateKey"];
        self.sinaWeiboManager.userID = sinaweiboInfo[@"UserIDKey"];
        
    }
}

- (void)registerSSOCallbackNotification{
    [Default_Notification_Center addObserver:self
                                    selector:@selector(handleSSOCallbackNotification:)
                                        name:Notification_For_URL_Scheme
                                      object:nil];
}

- (void)handleSSOCallbackNotification:(NSNotification*)notification{
    NSURL *url=(NSURL*)[notification object];
    if ([url.scheme isEqualToString:@"iBus"]) {
        [self.sinaWeiboManager handleOpenURL:url];
    }
}


#pragma mark - SinaWeiboDelegate Delegate -
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSDictionary *authInfo=@{
                             @"AccessTokenKey"      : sinaweibo.accessToken,
                             @"ExpirationDateKey"   : sinaweibo.expirationDate,
                             @"UserIDKey"           : sinaweibo.userID,
                             @"refresh_token"       : sinaweibo.refreshToken == nil ? @"" : sinaweibo.refreshToken
                            };
    
    [UserDefault setObject:authInfo forKey:@"SinaWeiboAuthData"];
    [UserDefault synchronize];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    [UserDefault removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    if (error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    if (error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }
}

#pragma mark - PublishBaseControllerDelegate -
- (void)publishBtn_handle:(id)sender{
    if (self.publishTxtView.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"还是说点什么吧"];
        return;
    }
    
    ShareToSinaWeiboOperation *operation=[[[ShareToSinaWeiboOperation alloc]
                                           initOperationWithContent:self.publishTxtView.text
                                           andImageSupportSwitch:self.imageSwitch] autorelease];
    [((AppDelegate*)appDelegateObj).operationQueueCenter addOperation:operation];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)atBtn_handle:(id)sender{
    FollowedSinaweiboController *followedListCtrller=
    [[[FollowedSinaweiboController alloc] initWithRefreshHeaderViewEnabled:NO
      
                                              andLoadMoreFooterViewEnabled:YES
      
                                                         andTableViewFrame:TableView_Frame_WithTabBarHeight] autorelease];
    
    UINavigationController *followedListNavCtrller=[[[UINavigationController alloc] initWithRootViewController:followedListCtrller] autorelease];
    
    [self presentViewController:followedListNavCtrller animated:YES completion:nil];
}


@end
