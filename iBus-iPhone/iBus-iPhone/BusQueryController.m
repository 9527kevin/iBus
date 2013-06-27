//
//  BusQueryController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BusQueryController.h"
#import "LineListController.h"

@interface BusQueryController ()

@property (nonatomic,retain) UIButton *queryByLineBtn;
@property (nonatomic,retain) UIButton *queryByStationBtn;
@property (nonatomic,retain) UIButton *queryByExchangeBtn;

@end

@implementation BusQueryController

- (void)dealloc{
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initQueryMenuItems];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self initNavigationController];
    self.navigationItem.title=@"公交查询";
    [self registerEventsForQueryMenuItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -

- (void)initQueryMenuItems{
    //按线路查询
    _queryByLineBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.queryByLineBtn.frame=CGRectMake(50, 50, 100, 40);
    [self.queryByLineBtn setTitle:@"按线路查询" forState:UIControlStateNormal];
    [self.view addSubview:self.queryByLineBtn];
    
    //按站点查询
    _queryByStationBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.queryByStationBtn.frame=CGRectMake(50, 150, 100, 40);
    [self.queryByStationBtn setTitle:@"按站点查询" forState:UIControlStateNormal];
    [self.view addSubview:self.queryByStationBtn];
    
    //换乘查询
    _queryByExchangeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.queryByExchangeBtn.frame=CGRectMake(50, 250, 100, 40);
    [self.queryByExchangeBtn setTitle:@"换乘查询" forState:UIControlStateNormal];
    [self.view addSubview:self.queryByExchangeBtn];
}

- (void)registerEventsForQueryMenuItems{
//    [self.queryByLineBtn addTarget:self action:@selector(Button_QueryByLine_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.queryByStationBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.queryByExchangeBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)Button_QueryByLine_TouchUpInside:(id)sender{
    LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
    [self.navigationController pushViewController:lineListCtrller animated:YES];
}





@end
