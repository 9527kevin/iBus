//
//  ThemeManager.m
//  iBus-iPhone
//
//  Created by yanghua on 7/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ThemeManager.h"
#import "ConfigItemDao.h"

static ThemeManager                         *_themeManager=nil;

@implementation ThemeManager

+ (ThemeManager*)sharedInstance{
    if (_themeManager==nil) {
        _themeManager=[[super allocWithZone:nil] init];
    }
    
    return _themeManager;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [[ThemeManager sharedInstance] retain];
}

+ (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)init{
    if (self=[super init]) {
        [self initCurrentTheme];
    }
    
    return self;
}

- (id)retain{
    return self;
}

- (NSUInteger)retainCount{
    return NSUIntegerMax;
}

- (oneway void)release{
    //
}

- (id)autorelease{
    return self;
}

#pragma mark - public static methods -
- (NSString *)changeTheme:(NSString*)themeName{
    if (!themeName || [themeName isEqualToString:@""]) {
        return nil;
    }
    
    NSString *themePath=[Bundle_Path_Of_ThemeResource stringByAppendingPathComponent:themeName];
    if (dirExistsAtPath(themePath)) {
        self.themePath=themePath;
        
        //update to db
        [ConfigItemDao set:[NSMutableDictionary dictionaryWithObjects:@[@"主题设置",themeName]
                                                              forKeys:@[@"itemKey",@"itemValue"]]];
        
        //init again
        [self initCurrentTheme];
    }
    
    return themeName;
}

    

- (UIImage*)themedImageWithName:(NSString*)imgName{
    if (!imgName || [imgName isEqualToString:@""]) {
        return nil;
    }
    
    NSString *imgPath=[self.themePath stringByAppendingPathComponent:imgName];
    
    return [UIImage imageWithContentsOfFile:imgPath];
}

#pragma mark - private methods -
- (void)initCurrentTheme{
    self.themeName=[ConfigItemDao get:@"主题设置"];
    NSString *themeColorStr=[ConfigItemDao get:self.themeName];
    self.themeColor=[UIColor parseColorFromStr:themeColorStr];
    self.themePath=[Bundle_Path_Of_ThemeResource stringByAppendingPathComponent:self.themeName];
    
    //init UI
    UIImage *navBarBackgroundImg=[[self themedImageWithName:@"themeColor.png"]
                                  resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 0.0f, 1.0f, 1.0f)
                                                resizingMode:UIImageResizingModeTile];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarBackgroundImg
                                       forBarMetrics:UIBarMetricsDefault];
}

@end
