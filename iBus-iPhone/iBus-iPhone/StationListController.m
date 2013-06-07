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

//@property (nonatomic,assign) int asyncCallbackCount;

@end

@implementation StationListController

- (void)dealloc{
    [_lineId release],_lineId=nil;
    [_lineName release],_lineName=nil;
    [_identifier release],_identifier=nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_For_LoadCountDownTimeCallbackCompleted object:nil];
    
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
    
//    [self loadCountDownTimeAsync];
    
//    [self registerNotification];
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
        int stationNo=indexPath.row+1;
        LineDynamicStateController *lineDynamicStateCtrller=[[[LineDynamicStateController alloc] init] autorelease];
        lineDynamicStateCtrller.lineId=self.lineId;
        lineDynamicStateCtrller.identifier=self.identifier;
        lineDynamicStateCtrller.stationNo=stationNo;
        [self.navigationController pushViewController:lineDynamicStateCtrller animated:YES];
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
    
//    //if is entry station , set background color: red to show warnning!
//    NSMutableDictionary *stationInfo=self.dataSource[indexPath.row];
//    if (stationInfo[@"entryStation"]) {
//        if ([stationInfo[@"entryStation"] boolValue]==YES) {
//            [cell setBackgroundColor:[UIColor redColor]];
//        }
//    }
    
}

//- (void)loadCountDownTimeAsync{
//    if (self.dataSource.count>0) {
//        
//        //init counter
//        self.asyncCallbackCount=0;
//        
//        for (int i=0; i<self.dataSource.count; i++) {
//            __block NSMutableArray *blockedDataSource=self.dataSource;
//            __block NSMutableDictionary *stationInfo=blockedDataSource[i];
//            __block StationListController *blockedStationListCtrller=self;
//            
//            NSURL *requestUrl=[NSURL URLWithString:[NSString stringWithFormat:Url_DestinationDistance,self.lineId,self.identifier,stationInfo[@"orderNo"]]];
//            
//            __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:requestUrl];
//            
//            [request setCompletionBlock:^{
//                
//                //add counter once invoked callback func
//                blockedStationListCtrller.asyncCallbackCount++;
//                
//                NSData *responseData=[request responseData];
//                NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseData
//                                                                          options:NSJSONReadingAllowFragments
//                                                                            error:nil];
//                //exist bus info
//                if ([responseDic[@"success"] boolValue]==true && responseDic[@"rows"] && [responseDic[@"rows"] count]>0) {
//                    NSDictionary *busInfo=responseDic[@"rows"][0];
//                    NSString *disStr=busInfo[@"dis"];
//                    if (disStr && disStr.length>0) {
//                        
//                        NSRange startRange=[disStr rangeOfString:@"约"
//                                                         options:NSBackwardsSearch];
//                        
//                        if ([disStr length]<startRange.location+1) {
//                            return;
//                        }
//                        
//                        disStr=[disStr substringFromIndex:startRange.location+1];
//                        NSRange endRange=[disStr rangeOfString:@"分钟"];
//                        
//                        if ([disStr length]<endRange.location) {
//                            return;
//                        }
//                        
//                        //count down time(minute)
//                        NSString *countDownTimeStr=[disStr substringToIndex:endRange.location];
//                        
//                        NSLog(@"%@",countDownTimeStr);
//                        
//                        stationInfo[@"countDownTime"]=countDownTimeStr;
//                        
//                    }
//                    
//                    //current station
//                    if ([busInfo[@"stationNo"] intValue]==0) {
//                        stationInfo[@"entryStation"]=[NSNumber numberWithBool:YES];
//                    }else{
//                        stationInfo[@"entryStation"]=[NSNumber numberWithBool:NO];
//                    }
//                }
//                
//                //unmatched condition before, repair it!
//                if (!stationInfo[@"countDownTime"]) {
//                    stationInfo[@"countDownTime"]=@"0";
//                }
//                
//                //if all callback funcs have completely, launch a notification
//                if (self.dataSource.count==self.asyncCallbackCount) {
//                    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_For_LoadCountDownTimeCallbackCompleted object:nil];
//                }
//                
//            }];
//            
//            [request startAsynchronous];
//        }
//        
//    }
//}
//
//- (void)registerNotification{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:Notification_For_LoadCountDownTimeCallbackCompleted object:nil];
//}
//
//- (void)notificationHandler:(NSNotification *)notification{
//    [self testPrintCountDownTime];
//    
//    //reload data source
//    [self.tableView reloadData];
//}
//
//
///**
// * test for printing countdown time
// */
//- (void)testPrintCountDownTime{
//    for (NSMutableDictionary *stationInfo in self.dataSource) {
//        NSLog(@"%@",stationInfo[@"countDownTime"]);
//    }
//}


@end
