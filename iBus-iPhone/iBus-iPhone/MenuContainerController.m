//
//  MenuContainer.m
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "MenuContainerController.h"

@interface MenuContainerController ()

//menu buttons
@property (nonatomic,retain) UIButton *busQueryBtn;
@property (nonatomic,retain) UIButton *myBusZoomBtn;

@end

@implementation MenuContainerController

- (void)dealloc{
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    [self initMenuContainer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -


- (void)initMenuContainer{
    UIView *menuContainerView=[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar];
    menuContainerView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:menuContainerView];
    
    //buttons
    _busQueryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.busQueryBtn setTitle:@"公交查询" forState:UIControlStateNormal];
    self.busQueryBtn.frame=CGRectMake(BusQueryBtn_Origin_X,
                                      BusQueryBtn_Origin_Y,
                                      MainContainer_MenuItem_Width,
                                      MainContainer_MenuItem_Height);
    [self.busQueryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.busQueryBtn.titleLabel setFont:[UIFont systemFontOfSize:MainContainer_MenuItem_Font]];
    [menuContainerView addSubview:self.busQueryBtn];
    
    _myBusZoomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.myBusZoomBtn setTitle:@"我的巴士空间" forState:UIControlStateNormal];
    [menuContainerView addSubview:self.myBusZoomBtn];
    
    [self.view addSubview:menuContainerView];
    [menuContainerView release];
}

#pragma mark - button events -
//- (void)

@end
