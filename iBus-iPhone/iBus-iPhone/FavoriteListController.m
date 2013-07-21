//
//  FollowingStationListController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "FavoriteListController.h"
#import "StationListController.h"
#import "LineDynamicStateController.h"
#import "LineDao.h"
#import "StationDao.h"

static NSString *cellForFavoriteIdentifier = @"cellForFavoriteIdentifier";

@interface FavoriteListController ()

@end

@implementation FavoriteListController

- (void)dealloc{
    [Default_Notification_Center removeObserver:self name:Notification_For_Favorited object:nil];
    
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavigationController];
    [self initDataSource];
    [self.tableView reloadData];
    [self registerNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)initNavigationController{
    [super initNavigationController];
    
    //right bar button item
    UIButton *refreshBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn  setBackgroundImage:[UIImage imageNamed:@"refreshBtn.png"] forState:UIControlStateNormal];
    refreshBtn.frame=CGRectMake(0, 0, 30.0f, 30.0f);
    [refreshBtn addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshBarBtn=[[[UIBarButtonItem alloc]initWithCustomView:refreshBtn] autorelease];
    self.navigationItem.rightBarButtonItem=refreshBarBtn;
    
    self.navigationItem.title=@"巴士空间";
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor=Default_TableView_BackgroundColor;
}

- (void)initDataSource{
    self.dataSourceForLine=[LineDao getAllFavorites];
    self.dataSourceForStation=[StationDao getAllFavorites];
}

- (void)handleRefresh:(id)sender{
    [self initDataSource];
    [self.tableView reloadData];
}

- (NSString*)getTextForLineCellWithNSIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *lineInfo=self.dataSourceForLine[indexPath.row];
    if (!lineInfo) {
        return @"";
    }
    
    NSString *txt=nil;
    if ([lineInfo[@"identifier_favorite"] isEqualToString:@"identifier_1_favorite"]) {
        txt=[NSString stringWithFormat:@"%@-%@",lineInfo[@"lineName"],@"去程"];
    }else if ([lineInfo[@"identifier_favorite"] isEqualToString:@"identifier_2_favorite"]){
        txt=[NSString stringWithFormat:@"%@-%@",lineInfo[@"lineName"],@"回程"];
    }else{
        txt=@"";
    }
    
    return txt;
}

- (NSString*)getTextForStationCellWithNSIndexPath:(NSIndexPath*)indexPath{
    NSDictionary *stationInfo=self.dataSourceForStation[indexPath.row];
    if (!stationInfo && !stationInfo[@"lineId"]) {
        return @"";
    }
    
    NSDictionary *lineInfo=[LineDao getLineInfoWithId:stationInfo[@"lineId"]];
    if (!lineInfo) {
        return @"";
    }
    
    NSString *txt=nil;
    if ([stationInfo[@"identifier_favorite"] isEqualToString:@"identifier_1_favorite"]) {
        txt=[NSString stringWithFormat:
                                        @"%@-%@-%@",
                                        stationInfo[@"stationName"],
                                        lineInfo[@"lineName"],
                                        @"去程"];
    }else if ([stationInfo[@"identifier_favorite"] isEqualToString:@"identifier_2_favorite"]){
        txt=[NSString stringWithFormat:
                                        @"%@-%@-%@",
                                        stationInfo[@"stationName"],
                                        lineInfo[@"lineName"],
                                        @"回程"];
    }else{
        txt=@"";
    }
    
    return txt;
}

- (void) unselectCurrentRow{
    // Animate the deselection
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
                                  animated:YES];
}

/*
 about notification
 */
- (void)registerNotification{
    [Default_Notification_Center addObserver:self
                                    selector:@selector(handleNotification:)
                                        name:Notification_For_Favorited
                                      object:nil];
}

- (void)handleNotification:(NSNotification*)notification{
    //refresh table view data
    [self handleRefresh:nil];
}

#pragma mark - UITableView data source and delegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title=nil;
    switch (section) {
        case 0:
            title=@"线路收藏列表";
            break;
            
        case 1:
            title=@"站点收藏列表";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    NSInteger count=0;
    switch (section) {
        case 0:
            count=[self.dataSourceForLine count];
            break;
            
        case 1:
            count=[self.dataSourceForStation count];
            break;
            
        default:
            break;
    }
    
    return count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=nil;
    
    cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellForFavoriteIdentifier] autorelease];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text=[self getTextForLineCellWithNSIndexPath:indexPath];
            break;
            
        case 1:
            cell.textLabel.text=[self getTextForStationCellWithNSIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    
    cell.textLabel.font=[UIFont systemFontOfSize:17.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *pushingCtrller=nil;
    NSDictionary *dic=nil;
    
    switch (indexPath.section) {
        case 0:
        {
            dic=self.dataSourceForLine[indexPath.row];
            
            NSString *identifier=[dic[@"identifier_favorite"] isEqualToString:@"identifier_1_favorite"] ? @"1" : @"2";
            
            StationListController *stationListCtrller=[[[StationListController alloc] init] autorelease];
            stationListCtrller.lineId=dic[@"lineId"];
            stationListCtrller.lineName=dic[@"lineName"];
            stationListCtrller.identifier=identifier;
            pushingCtrller=stationListCtrller;
        }
            break;
            
        case 1:
        {
            dic=self.dataSourceForStation[indexPath.row];
            NSString *identifier=[dic[@"identifier_favorite"] isEqualToString:@"identifier_1_favorite"] ? @"1" : @"2";
            LineDynamicStateController *lineDynamicStateCtrller=[[[LineDynamicStateController alloc] init] autorelease];
            lineDynamicStateCtrller.lineId=dic[@"lineId"];
            lineDynamicStateCtrller.identifier=identifier;
            lineDynamicStateCtrller.stationNo=[dic[@"orderNo"] intValue];
            lineDynamicStateCtrller.stationName=dic[@"stationName"];
            pushingCtrller=lineDynamicStateCtrller;
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:pushingCtrller animated:YES];
    
    // After one second, unselect the current row
    [self performSelector:@selector(unselectCurrentRow)
               withObject:nil afterDelay:1.0];
}



@end
