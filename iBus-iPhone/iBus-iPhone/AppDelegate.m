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
#import <GoogleMaps/GoogleMaps.h>

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
    
    [self initOperationQueueCenter];

    [self initPKRevealControllers];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.rootViewController=self.revealCtrller;
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    [self configDefaultUIAppearance];
    
    [GMSServices provideAPIKey:@"AIzaSyBwalOcYe-ONBL-TmFN66_sXncJFfI-T8A"];
    
    [NSThread sleepForTimeInterval:2];
    
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
    [[UINavigationBar appearance] setTintColor:Default_Theme_Color];
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
    }

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

}

@end
