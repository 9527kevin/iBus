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

#define isIPhone5 \
([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : \
NO)

#define ColorWithRGBA(r,g,b,a) \
[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define fileExistsAtPath(x) [[NSFileManager defaultManager] fileExistsAtPath:x]
#define removerAtItem(x) [[NSFileManager defaultManager] removeItemAtPath:x error:nil]
#define appDelegateObj [[UIApplication sharedApplication] delegate]

#define Default_TableView_Frame CGRectMake(ZERO_Original_X,\
                                            ZERO_Original_Y,\
                                            MainWidth,\
                                MainHeight-NavigationBarHeight-TabBarHeight)

#define TableView_Frame_WithTabBarHeight CGRectMake(ZERO_Original_X,\
                                                    ZERO_Original_Y,\
                                                    MainWidth,\
                                        MainHeight-NavigationBarHeight)

#define Default_Frame_WithoutStatusBar CGRectMake(ZERO_Original_X,\
                                                    ZERO_Original_Y,\
                                                    MainWidth,\
                                                    MainHeight)


#define MainContainer_MenuItem_Width 60.0f
#define MainContainer_MenuItem_Height 60.0f

#define MainContainer_MenuItem_Font 15.0f

