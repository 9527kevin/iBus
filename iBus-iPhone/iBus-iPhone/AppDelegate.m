//
//  AppDelegate.m
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuContainerController.h"
#import "BusQueryController.h"
#import "LineListController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Appirater.h"
#import "YISplashScreen.h"
#import "YISplashScreenAnimation.h"
#import "ConfigItemDao.h"

@interface AppDelegate ()

@property (nonatomic,retain) PKRevealController *revealCtrller;

@end

@implementation AppDelegate

- (void)dealloc
{
    [_operationQueueCenter release],_operationQueueCenter=nil;
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initDatabase];
    
    // show splash
    [YISplashScreen show];
    
    [self configAppirater];
    
    [self initOperationQueueCenter];

    [self initPKRevealControllers];
    
    [self fadeOutLaunch];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController=self.revealCtrller;
    [self.window makeKeyAndVisible];
        
    [GMSServices provideAPIKey:@"AIzaSyBwalOcYe-ONBL-TmFN66_sXncJFfI-T8A"];
    
    
    [Appirater appLaunched:YES];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url{
    //send message, now is for sina weibo  SSO
    [Default_Notification_Center postNotificationName:Notification_For_URL_Scheme object:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    //send message, now is for sina weibo  SSO
    [Default_Notification_Center postNotificationName:Notification_For_URL_Scheme object:url];
    return YES;
}

- (void)initDatabase{
    if (!fileExistsAtPath(PATH_OF_DB)) {
        
//#if TARGET_IPHONE_SIMULATOR
//        [[DBHelper sharedInstance] initWithCreatingTablesForDatabase:PATH_OF_DB
//                                                         andSQLArray:CREATE_TABLE_SQL_ARRAY];
//#elif TARGET_OS_IPHONE
//        NSString *resourcePath =[[NSBundle mainBundle] pathForResource:@"BusDB"
//                                                                ofType:@"db"];
//
//        NSData *dbFile = [NSData dataWithContentsOfFile:resourcePath];
//        [[NSFileManager defaultManager] createFileAtPath:PATH_OF_DB contents:dbFile attributes:nil];
//#endif
        
        NSString *resourcePath =[[NSBundle mainBundle] pathForResource:@"BusDB"
                                                                ofType:@"db"];
        
        NSData *dbFile = [NSData dataWithContentsOfFile:resourcePath];
        [[NSFileManager defaultManager] createFileAtPath:PATH_OF_DB contents:dbFile attributes:nil];
        NSLog(@"%@",PATH_OF_DB);
    }
    NSLog(@"%@",PATH_OF_DB);
}

- (void)initOperationQueueCenter{
    _operationQueueCenter=[[NSOperationQueue alloc] init];
}

- (void)initPKRevealControllers{
    NSDictionary *options = @{
            PKRevealControllerAllowsOverdrawKey : [NSNumber numberWithBool:YES],
            PKRevealControllerDisablesFrontViewInteractionKey : [NSNumber numberWithBool:YES]
                            };
    
    //rear controller
    MenuContainerController *menuContaonerCtrller=[[[MenuContainerController alloc] init] autorelease];
    
    //front controller
    BusQueryController *busQueryCtrller=[[[BusQueryController alloc] init] autorelease];
    UINavigationController *busQueryNavCtrller=[[[UINavigationController alloc] initWithRootViewController:busQueryCtrller] autorelease];
    
    _revealCtrller = [PKRevealController revealControllerWithFrontViewController:busQueryNavCtrller
                                                              leftViewController:menuContaonerCtrller
                                                                         options:options];
    self.revealCtrller.revealPanGestureRecognizer.enabled=NO;

}

- (void)configAppirater{
    [Appirater setAppId:AppID];
    [Appirater setDaysUntilPrompt:1];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:7];
    [Appirater setDebug:NO];
}

- (void)fadeOutLaunch{
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    
    NSLog(@"%@",[ConfigItemDao get:@"启动动画"]);
    int animationFlag=[[ConfigItemDao get:@"启动动画"] intValue];
    
    switch (animationFlag) {
        case 0:
        {
            [YISplashScreen hideWithAnimations:^(CALayer* splashLayer) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:0.7];
                [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [CATransaction setCompletionBlock:^{
                    
                }];
                
                splashLayer.position = CGPointMake(splashLayer.position.x, splashLayer.position.y-splashLayer.bounds.size.height);
                
                [CATransaction commit];
            }];
        }
            break;
        
        case 1:
            [YISplashScreen hide];
            break;
            
        case 2:
        {
            [YISplashScreen hideWithAnimations:[YISplashScreenAnimation pageCurlAnimation]];
        }
            break;
    }
}


@end
