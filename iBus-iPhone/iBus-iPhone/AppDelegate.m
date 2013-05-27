//
//  AppDelegate.m
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "AppDelegate.h"
#import "ZUUIRevealController.h"
#import "MenuContainerController.h"
#import "BusQueryController.h"

@interface AppDelegate ()

@property (nonatomic,retain) ZUUIRevealController *zuuiRevealCtrller;


@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_operationQueueCenter release],_operationQueueCenter=nil;
    [_zuuiRevealCtrller release],_zuuiRevealCtrller=nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //front controller
    MenuContainerController *menuContaonerCtrller=[[[MenuContainerController alloc] init] autorelease];
        
    //rear controller
    BusQueryController *busQueryCtrller=[[[BusQueryController alloc] init] autorelease];
    UINavigationController *busQueryNavCtrller=[[[UINavigationController alloc] initWithRootViewController:busQueryCtrller] autorelease];
    
    self.zuuiRevealCtrller=[[ZUUIRevealController alloc] initWithFrontViewController:busQueryNavCtrller rearViewController:menuContaonerCtrller];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController=self.zuuiRevealCtrller;
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    [self configDefaultUIAppearance];
    
    [self initDatabase];
    
    [self initOperationQueueCenter];
    
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)configDefaultUIAppearance{
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    [[UINavigationBar appearance] setTintColor:[UIColor grayColor]];
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)initDatabase{
    if (!fileExistsAtPath(PATH_OF_DB)) {
        [[DBHelper sharedInstance] initWithCreatingTablesForDatabase:PATH_OF_DB
                                                         andSQLArray:CREATE_TABLE_SQL_ARRAY];
    }
}

- (void)initOperationQueueCenter{
    _operationQueueCenter=[[NSOperationQueue alloc] init];
}

@end
