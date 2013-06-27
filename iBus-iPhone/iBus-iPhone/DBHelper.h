//
//  DBHelper.h
//  NanJingUniversity
//
//  Created by yanghua_kobe on 12/9/12.
//  Copyright (c) 2012 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHelper : NSObject

+ (DBHelper*)sharedInstance;

- (void)deleteDatabase:(NSString*)databasePath;

- (void)initWithCreatingTablesForDatabase:(NSString*)databasePath andSQLArray:(NSArray*)sqlArr;

@end
