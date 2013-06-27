//
//  LineList_test_Controller.h
//  iBus-iPhone
//
//  Created by yanghua on 5/29/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"
#import "UIFolderTableView.h"


@interface LineListController : BaseController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray     *dataSource;
@property (nonatomic,retain) UIFolderTableView  *tableView;

/*
 是否设置界面的调用
 */
@property (nonatomic,assign) Boolean            isSetting;

@end
