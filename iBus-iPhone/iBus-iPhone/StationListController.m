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
#import "StationMapInfoController.h"
#import "LineDynamicStateController.h"

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
    self.navigationItem.title=[NSString stringWithFormat:@"%@-站点列表",self.lineName];
    self.dataSource=[StationDao getStationListWithLineId:self.lineId andIdentifier:self.identifier];
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
    
    self.didSelectRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        LineDynamicStateController *lineDynamicStateCtrller=[[LineDynamicStateController alloc] init];
        lineDynamicStateCtrller.lineId=self.lineId;
        lineDynamicStateCtrller.identifier=self.identifier;
        lineDynamicStateCtrller.stationNo=[self.dataSource[indexPath.row][@"orderNo"] intValue];
        lineDynamicStateCtrller.stationName=self.dataSource[indexPath.row][@"stationName"];
        [self.navigationController pushViewController:lineDynamicStateCtrller animated:YES];
        [lineDynamicStateCtrller release];
    };
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 2 == 1){
        [cell setBackgroundColor:ColorWithRGBA(235, 235, 235, 1.0)];
    }
    else{
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
}

#pragma mark - private methods -
- (void)initNavBarRightItem{
#warning query from db
    BOOL isLineFavorite=NO;
    
    NSString *barBtnItemText=nil;
    if (isLineFavorite) {
        barBtnItemText = @"取消收藏";
    }else{
        barBtnItemText = @"添加收藏";
    }
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc] initWithTitle:barBtnItemText
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleFavorite:)];
    
    self.navigationItem.leftBarButtonItem = favoriteButton;
    [favoriteButton release];
}

- (void)handleFavorite:(id)sender{
    UIBarButtonItem *favoriteButton=(UIBarButtonItem*)sender;
    
#warning query from db
    BOOL isLineFavorite=NO;
    
    NSString *barBtnItemText=nil;
    if (isLineFavorite) {
        //do unfavorite
        barBtnItemText = @"添加收藏";
    }else{
        //do favorite
        barBtnItemText = @"取消收藏";
    }
    
    favoriteButton.title=barBtnItemText;
}

@end
