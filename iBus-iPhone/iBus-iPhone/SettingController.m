//
//  SettingController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SettingController.h"

static NSString *settingTableViewCell = @"settingTableViewCell";

@interface SettingController ()

@end

@implementation SettingController

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    _tableView=[[[UITableView alloc] initWithFrame:Default_TableView_Frame
                                             style:UITableViewStyleGrouped] autorelease];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
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
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController
                                                                                                            action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导航菜单"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self.navigationController.parentViewController
                                                                                action:@selector(revealToggle:)];
        
        self.navigationItem.title=@"设置";
	}
}

#pragma mark - UITableView data source and delegate -
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
    return ((NSArray*)(self.dataSource[[NSString stringWithFormat:@"%d",section]])).count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingTableViewCell];
    cell.textLabel.text=self.dataSource[[NSString stringWithFormat:@"%d",indexPath.section]][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:                 //公交设置
        {
            
        }
            
            break;
            
        case 1:                 //应用设置
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)initDataSource{
    _dataSource = [NSMutableDictionary dictionary];
    
    //section 0
    NSArray *section_0=[[[NSArray alloc] initWithObjects: @"默认线路", @"关注站点", nil] autorelease];
    [self.dataSource setObject:section_0 forKey:@"0"];
    
    //section 1
    NSArray *section_1=[[[NSArray alloc] initWithObjects:@"刷新频率", @"同步数据", nil] autorelease];
    [self.dataSource setObject:section_1 forKey:@"1"];
}


@end
