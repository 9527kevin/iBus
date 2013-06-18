//
//  ConfigItemDao.h
//  iBus-iPhone
//
//  Created by yanghua on 6/13/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECT_CONFIGITEM_BY_CATEGORYID \
@"SELECT * FROM configItem WHERE categoryId = ?"

#define SELECT_CONFIGITEM_BY_ITEMKEY \
@"SELECT * FROM configItem WHERE itemKey = ?"

#define INSERT_CONFIGITEM \
@"INSERT INTO configItem(itemKey,itemValue,categoryId) VALUES(:itemKey,:itemValue,:categoryId)"

#define UPDATE_CONFIGITEM_BY_ITEMKEY \
@"UPDATE configItem SET itemValue = :itemValue WHERE itemKey = :itemKey"

#define DELETE_CONFIGITEM_BY_ITEMKEY \
@"DELETE FROM configItem WHERE itemKey = ?"

#define CHECK_CONFIGITEM_EXISTS \
@"SELECT COUNT(1) FROM configItem WHERE itemKey = ?"

@interface ConfigItemDao : NSObject

+ (NSMutableArray*)getItemWithCategoryId:(NSString*)categoryId;

+ (NSString*)get:(NSString*)key;

+ (void)add:(NSMutableDictionary*)configItem;

+ (void)set:(NSMutableDictionary*)configItem;

+ (void)removeByItemKey:(NSString*)key;

@end
