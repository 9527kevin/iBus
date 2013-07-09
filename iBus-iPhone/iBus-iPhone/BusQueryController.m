//
//  BusQueryController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BusQueryController.h"
#import "LineListController.h"
#import "SIAlertView.h"
#import "LineDao.h"

typedef enum {
    BY_LINENAME         =0,
    BY_STATIONNAME      =1,
    BY_EXCHANGE         =2
}ENUM_QueryType;

@interface BusQueryController ()

@property (nonatomic,retain) UIButton               *querySelectBtn;
@property (nonatomic,retain) UITextField            *queryTxtField;
@property (nonatomic,retain) UIButton               *queryBtn;

@property (nonatomic,retain) NSMutableArray         *queryDataSource;
@property (nonatomic,assign) ENUM_QueryType         queryType;

@end

@implementation BusQueryController

- (void)dealloc{
    [_queryTxtField release],_queryTxtField=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    _querySelectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.querySelectBtn setBackgroundImage:[[UIImage imageNamed:@"defaultThemeColor.png"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 1) resizingMode:UIImageResizingModeTile]
                                   forState:UIControlStateNormal];
    self.querySelectBtn.frame=QuerySelect_Button_Frame;
    [self.querySelectBtn setTitle:@"按线路查询" forState:UIControlStateNormal];
    [self.querySelectBtn.titleLabel setFont:[UIFont systemFontOfSize:QuerySelect_Button_FontSize]];
    [self.querySelectBtn addTarget:self
                            action:@selector(menuBtn_touchUpInside:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.querySelectBtn];
    
    _queryTxtField=[[UITextField alloc] initWithFrame:Query_TextField_Frame];
    self.queryTxtField.placeholder=@"";
    self.queryTxtField.font=[UIFont systemFontOfSize:Query_TextField_FontSize];
    [self.queryTxtField setAdjustsFontSizeToFitWidth:YES];
    self.queryTxtField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    self.queryTxtField.delegate=self;
    self.queryTxtField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.queryTxtField];
    
    _queryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.queryBtn setBackgroundImage:[[UIImage imageNamed:@"defaultThemeColor.png"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 1, 1) resizingMode:UIImageResizingModeTile]
                                   forState:UIControlStateNormal];
    self.queryBtn.frame=Query_Button_Frame;
    [self.queryBtn setTitle:@"查 询" forState:UIControlStateNormal];
    [self.queryBtn.titleLabel setFont:[UIFont systemFontOfSize:Query_Button_FontSize]];
    [self.queryBtn addTarget:self
                      action:@selector(queryButton_touchUpInside:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.queryType=BY_LINENAME;             //init query type
	[self initNavigationController];
    self.navigationItem.title=@"公交查询";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods -
- (void)menuBtn_touchUpInside:(id)sender{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"查询类型"
                                                     andMessage:@"请选择以下的查询类型"];
    [alertView addButtonWithTitle:@"按线路查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [self.querySelectBtn setTitle:@"按线路查询"
                                                   forState:UIControlStateNormal];
                              self.queryTxtField.placeholder=@"请输入线路名称";
                              self.queryType=BY_LINENAME;
                          }];
    [alertView addButtonWithTitle:@"按站点查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [self.querySelectBtn setTitle:@"按站点查询"
                                                   forState:UIControlStateNormal];
                              self.queryTxtField.placeholder=@"请输入站点名称";
                              self.queryType=BY_STATIONNAME;
                          }];
    [alertView addButtonWithTitle:@"按换乘查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [self.querySelectBtn setTitle:@"按换乘查询"
                                                   forState:UIControlStateNormal];
                              self.queryTxtField.placeholder=@"示例:从安德门到托乐嘉";
                              self.queryType=BY_EXCHANGE;
                          }];
    
    alertView.titleColor = [UIColor grayColor];
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
    };
    
    alertView.didShowHandler = ^(SIAlertView *alertView) {
    };
    
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
    };
    
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
    };
    
    [alertView show];
    
}

- (void)queryButton_touchUpInside:(id)sender{
    NSString *queryStr=self.queryTxtField.text;
        
    switch (self.queryType) {
        case BY_LINENAME:
            [self queryLineWithLineName:queryStr];
            break;
            
        case BY_STATIONNAME:
            [self queryLineWithStationName:queryStr];
            break;
            
        case BY_EXCHANGE:
            [self queryLineWithStationExchange:queryStr];
            break;
            
        default:
            break;
    }
    
    if (!self.queryDataSource) {
        [SVProgressHUD showErrorWithStatus:@"无匹配结果!"];
        return;
    }
    
    LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
    lineListCtrller.dataSource=self.queryDataSource;
    lineListCtrller.isSetting=YES;
    [self.navigationController pushViewController:lineListCtrller animated:YES];
}


- (void)queryLineWithLineName:(NSString*)queryStr{
    self.queryDataSource=[LineDao queryLineWithLineName:queryStr];
}

- (void)queryLineWithStationName:(NSString*)queryStr{
    self.queryDataSource=[LineDao queryLineWithStationName:queryStr];
}

- (void)queryLineWithStationExchange:(NSString*)queryStr{
#warning split the querystr
    NSString *startStation=@"";
    NSString *endStation=@"";
    
    self.queryDataSource=[LineDao queryLineWithStartStation:startStation
                                              andEndStation:endStation];
}







@end
