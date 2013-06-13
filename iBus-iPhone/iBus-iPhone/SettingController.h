//
//  SettingController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

@interface SettingController : BaseController
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic,retain) NSMutableDictionary *dataSource;
@property (nonatomic,retain) NSMutableArray *categoryArray;
@property (nonatomic,retain) UITableView *tableView;

@end
