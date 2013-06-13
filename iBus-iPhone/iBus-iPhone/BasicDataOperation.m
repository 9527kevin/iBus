//
//  BasicDataOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 6/13/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BasicDataOperation.h"
#import "ConfigCategoryDao.h"
#import "ConfigItemDao.h"

@implementation BasicDataOperation

- (void)main{
    [self initConfigCategory];
    [self initConfigDefaultItem];
}

#pragma mark - private methods -
- (void)initConfigCategory{
    NSMutableDictionary *busSetting=[NSMutableDictionary
                                     dictionaryWithDictionary:@{
                                     @"categoryId": @"cc_busSetting",
                                     @"categoryName":@"公交设置",
                                     @"sectionNo":@"0"
                                     }];
    [ConfigCategoryDao add:busSetting];
    
    NSMutableDictionary *appSetting=[NSMutableDictionary
                                     dictionaryWithDictionary:@{
                                     @"categoryId": @"cc_appSetting",
                                     @"categoryName":@"应用设置",
                                     @"sectionNo":@"1"
                                     }];
    [ConfigCategoryDao add:appSetting];
}

- (void)initConfigDefaultItem{
    //bus setting
    NSMutableDictionary *defaultLine=[NSMutableDictionary
                                     dictionaryWithDictionary:@{
                                     @"itemKey": Setting_Key_DefaultLine,
                                     @"itemValue":@"",
                                     @"categoryId":@"cc_busSetting"
                                     }];
    [ConfigItemDao add:defaultLine];
    
    NSMutableDictionary *followedStation=[NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                      @"itemKey": Setting_Key_FollowStation,
                                      @"itemValue":@"",
                                      @"categoryId":@"cc_busSetting"
                                      }];
    [ConfigItemDao add:followedStation];
    
    //app setting
    NSMutableDictionary *refreshTime=[NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                      @"itemKey": Setting_Key_RefreshFrequency,
                                      @"itemValue":@"20",
                                      @"categoryId":@"cc_appSetting"
                                      }];
    [ConfigItemDao add:refreshTime];
    
}

@end
