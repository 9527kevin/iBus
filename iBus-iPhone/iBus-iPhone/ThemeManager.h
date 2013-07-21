//
//  ThemeManager.h
//  iBus-iPhone
//
//  Created by yanghua on 7/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

//the path in the sandbox
#define Base_Path_Of_ThemeDir                                               \
[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"Themes"]

#define Bundle_Of_ThemeResource                         @"ThemeResource"

//the path in the bundle
#define Bundle_Path_Of_ThemeResource                                        \
[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:Bundle_Of_ThemeResource]

@interface ThemeManager : NSObject

@property (nonatomic,copy) NSString                 *themeName;
@property (nonatomic,copy) NSString                 *themePath;
@property (nonatomic,retain) UIColor                *themeColor;

+ (ThemeManager*)sharedInstance;

- (NSString *)changeTheme:(NSString*)themeName;

- (UIImage*)themedImageWithName:(NSString*)imgName;


@end
