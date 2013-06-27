//
//  ConfigCategoryDao.h
//  iBus-iPhone
//
//  Created by yanghua on 6/13/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECT_ALLCONFIGCATEGORY                                            \
@"SELECT * FROM configCategory ORDER BY sectionNo ASC"

#define SELECT_CONFIGCATEGORY_BY_SECTIONNO                                  \
@"SELECT * FROM configCategory WHERE sectionNo = ?"

#define INSERT_CONFIGCATEGORY                                               \
@"INSERT INTO configCategory(categoryId,categoryName,sectionNo) VALUES(:categoryId, :categoryName, :sectionNo)"

#define CHECK_EXISTS_CONFIGCATEGORY_SQL                                     \
@"SELECT COUNT(1) FROM configCategory "

@interface ConfigCategoryDao : NSObject

+ (NSMutableArray*)getAll;

+ (NSMutableArray*)getCategory:(NSString*)sectionNo;

+ (void)add:(NSMutableDictionary*)configCategory;

+ (BOOL)checkIsInited;

@end
