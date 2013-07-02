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

@interface BusQueryController ()

@property (nonatomic,retain) UIButton               *queryByLineBtn;
@property (nonatomic,retain) UIButton               *queryByStationBtn;
@property (nonatomic,retain) UIButton               *queryByExchangeBtn;

@property (nonatomic,retain) NSArray                *menuItemArray;

@end

@implementation BusQueryController

- (void)dealloc{
    [_menuItemArray release],_menuItemArray=nil;
    
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
    [self initMenuItems];
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
    [self.queryByLineBtn addTarget:self
                            action:@selector(menuBtn_touchUpInside:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryByLineBtn];
    
    //按站点查询
    _queryByStationBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.queryByStationBtn.frame=CGRectMake(50, 150, 100, 40);
    [self.queryByStationBtn setTitle:@"按站点查询" forState:UIControlStateNormal];
    [self.queryByStationBtn addTarget:self
                               action:@selector(menuBtn_touchUpInside:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryByStationBtn];
    
    //换乘查询
    _queryByExchangeBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.queryByExchangeBtn.frame=CGRectMake(50, 250, 100, 40);
    [self.queryByExchangeBtn setTitle:@"换乘查询" forState:UIControlStateNormal];
    [self.queryByExchangeBtn addTarget:self
                               action:@selector(menuBtn_touchUpInside:)
                     forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.queryByExchangeBtn];
}

- (void)menuBtn_touchUpInside:(id)sender{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"查询类型" andMessage:@""];
    [alertView addButtonWithTitle:@"按线路查询"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Button1 Clicked");
                          }];
    [alertView addButtonWithTitle:@"按站点查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Button2 Clicked");
                          }];
    [alertView addButtonWithTitle:@"换乘查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Button3 Clicked");
                          }];
    
    alertView.titleColor = [UIColor grayColor];
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        
    };
    
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler2", alertView);
    };
    
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler2", alertView);
    };
    
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler2", alertView);
    };
    
    [alertView show];
    
}

- (void)Button_QueryByLine_TouchUpInside:(id)sender{
    LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
    [self.navigationController pushViewController:lineListCtrller animated:YES];
}

- (void)initMenuItems{
    _menuItemArray=[[NSArray alloc] initWithObjects:
                    
                    nil];
}

- (void)menuItem_touchUpInside:(id)sender{
    
}



@end
