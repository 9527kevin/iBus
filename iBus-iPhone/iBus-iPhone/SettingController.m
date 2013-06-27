//
//  SettingController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SettingController.h"
#import "ConfigCategoryDao.h"
#import "ConfigItemDao.h"

#import "LineListController.h"
#import "RefreshFrequencyController.h"

static NSString *settingTableViewCell = @"settingTableViewCell";

@interface SettingController ()

@end

@implementation SettingController

- (void)dealloc{
    [_dataSource release],_dataSource=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    _tableView=[[[UITableView alloc] initWithFrame:Default_TableView_Frame
                                             style:UITableViewStyleGrouped] autorelease];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor=Default_TableView_BackgroundColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavigationController];
    [self initDataSource];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)initNavigationController{
    [super initNavigationController];
    self.navigationItem.title=@"设置";
}

- (void) unselectCurrentRow{
    // Animate the deselection
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
                                  animated:YES];
}

- (void)initDataSource{
    _dataSource = [[NSMutableDictionary alloc] init];
    _categoryArray=[ConfigCategoryDao getAll];
    for (NSDictionary *category in self.categoryArray) {
        NSMutableArray *configItems=[ConfigItemDao getItemWithCategoryId:category[@"categoryId"]];
        self.dataSource[category[@"sectionNo"]]=configItems;
    }
    
}

#pragma mark - UITableView data source and delegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.categoryArray.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.categoryArray[section][@"categoryName"];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return ((NSMutableArray*)(self.dataSource[[NSNumber numberWithInt:section]])).count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    
    cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingTableViewCell] autorelease];
    cell.textLabel.text=[((NSMutableDictionary*)self.dataSource[[NSNumber numberWithInt:indexPath.section]][indexPath.row]) allKeys][0];
    cell.textLabel.font=[UIFont systemFontOfSize:17.0f];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *sectionKey=[NSNumber numberWithInt:indexPath.section];
    NSString *itemKey=[((NSMutableDictionary*)self.dataSource[sectionKey][indexPath.row]) allKeys][0];
    if ([itemKey isEqualToString:Setting_Key_DefaultLine]) {
        LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
        lineListCtrller.isSetting=YES;
        [self.navigationController pushViewController:lineListCtrller animated:YES];
    }else if ([itemKey isEqualToString:Setting_Key_FollowStation]){
        LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
        lineListCtrller.isSetting=YES;
        [self.navigationController pushViewController:lineListCtrller animated:YES];
    }else if([itemKey isEqualToString:Setting_Key_RefreshFrequency]){
        RefreshFrequencyController *refreshFrequencyCtrller=[[[RefreshFrequencyController alloc] init] autorelease];
        [self.navigationController pushViewController:refreshFrequencyCtrller animated:YES];
    }
    
    // After one second, unselect the current row
    [self performSelector:@selector(unselectCurrentRow)
               withObject:nil afterDelay:1.0];
    
}



@end
