//
//  StationListControllerViewController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationListController.h"
#import "StationListCell.h"
#import "StationDao.h"

static NSString *stationListIdentifier=@"stationListIdentifier";

@interface StationListController ()

@end

@implementation StationListController

- (void)dealloc{
    [_lineId release],_lineId=nil;
    [_lineName release],_lineName=nil;
    [_identifier release],_identifier=nil;
    
    [super dealloc];
}

- (id)initWithRefreshHeaderViewEnabled:(BOOL)enableRefreshHeaderView andLoadMoreFooterViewEnabled:(BOOL)enableLoadMoreFooterView andTableViewFrame:(CGRect)frame{
    self=[super initWithRefreshHeaderViewEnabled:enableRefreshHeaderView andLoadMoreFooterViewEnabled:enableLoadMoreFooterView];
    if (self) {
        self.tableViewFrame=frame;
    }
    
    return self;
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBlocks];
    self.navigationController.title=[NSString stringWithFormat:@"%@-站点列表",self.lineName];
    self.dataSource=[StationDao getStationListWithLineId:self.lineId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)initBlocks{
    [super initBlocks];
    
    self.heightForRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        return 50.0f;
    };
    
    self.cellForRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        StationListCell *cell=(StationListCell*)[tableView dequeueReusableCellWithIdentifier:stationListIdentifier];
        if (!cell) {
            cell=[[[StationListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stationListIdentifier] autorelease];
        }
        
        cell.stationInfo=self.dataSource[indexPath.row];
        
        [cell initSubViewsWithModel:self.dataSource[indexPath.row]];
        [cell resizeSubViews];
        
        return cell;
    };
}


@end
