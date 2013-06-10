//
//  SettingController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()

@end

@implementation SettingController

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"设置";
    
    _tableView=[[[UITableView alloc] initWithFrame:Default_TableView_Frame style:UITableViewStylePlain] autorelease];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data source and delegate -
#pragma mark - table view delegate and datasource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"公交设置";
            
        case 1:
            return @"应用设置";
            
        default:
            return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 1;
        default:
            return 0;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:                     //bind and share
        {
            
        }
            
            break;
            
        case 1:                 //fonts and colors
        {
            
        }
            break;
            
        case 2:                 //audio
        {
            
        }
            break;
            
        case 3:                 //others
        {
            
            
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:                 //绑定－平台
        {
            
        }
            
            break;
            
        case 1:
        {
            
        }
            break;
            
        case 3:
        {
            
        }
            
            break;
            
        default:
            break;
    }
    
}

- (void)initDataSource{
    
}


@end
