//
//  GlobalDefinitionForUI.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define StateBarHeight 20
#define MainHeight (ScreenHeight - StateBarHeight)
#define MainWidth ScreenWidth
#define ZERO_Original_X 0
#define ZERO_Original_Y 0
#define TabBarHeight 49
#define NavigationBarHeight 44

#define isIPhone5                                                           \
([UIScreen instancesRespondToSelector:@selector(currentMode)] ?             \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : \
NO)

#define ColorWithRGBA(r,g,b,a) \
[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define fileExistsAtPath(x) [[NSFileManager defaultManager] fileExistsAtPath:x]
#define removerAtItem(x) [[NSFileManager defaultManager] removeItemAtPath:x error:nil]
#define appDelegateObj [[UIApplication sharedApplication] delegate]

#define Default_TableView_Frame CGRectMake(ZERO_Original_X,                 \
                                            ZERO_Original_Y,                \
                                            MainWidth,                      \
                                MainHeight-NavigationBarHeight)

#define TableView_Frame_WithTabBarHeight CGRectMake(ZERO_Original_X,        \
                                                    ZERO_Original_Y,        \
                                                    MainWidth,              \
                                        MainHeight-NavigationBarHeight)

#define Default_Frame_WithoutStatusBar CGRectMake(ZERO_Original_X,          \
                                                    ZERO_Original_Y,        \
                                                    MainWidth,              \
                                                    MainHeight)

#define Default_TableView_BackgroundColor ColorWithRGBA(235, 235, 235, 1.0)
#define Default_Theme_Color ColorWithRGBA(36, 160, 73, 1.0)

#define Default_HeadImg_Size CGSizeMake(30.0f, 30.0f)

#define Middle_HeadImg_Size CGSizeMake(50.0f, 50.0f)


#define fileExistsAtPath(x) [[NSFileManager defaultManager] fileExistsAtPath:x]
#define removerItemAtPath(x) [[NSFileManager defaultManager] removeItemAtPath:x error:nil]
#define appDelegateObj [[UIApplication sharedApplication] delegate]

#define UserDefault                         [NSUserDefaults standardUserDefaults]
#define NSFileDefaultManager                [NSFileManager defaultManager]
#define Default_Notification_Center         [NSNotificationCenter defaultCenter]


//common paths
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT                                                    \
[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//db path
#define Database_Name @"BusDB.db"
#define PATH_OF_DB [PATH_OF_DOCUMENT stringByAppendingPathComponent:Database_Name]

//url scheme
#define URL_OF_SHEME @"iBus" 

#define AppID @"667862622"

#define URL_OF_AppStore @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@"

#define Resource_OF_AdImage @"AppAd.png"