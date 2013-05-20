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
@property (nonatomic,retain) UIView *busQueryMenuView;
@property (nonatomic,retain) UIView *myBusZoomView;
@property (nonatomic,retain) UIView *aboutView;
@property (nonatomic,retain) UIView *findFriendView;
@property (nonatomic,retain) UIView *mapShowView;

@end

@implementation MenuContainerController

- (void)dealloc{
    [_busQueryMenuView release],_busQueryMenuView=nil;
    [_myBusZoomView release],_myBusZoomView=nil;
    [_aboutView release],_aboutView=nil;
    [_findFriendView release],_findFriendView=nil;
    [_mapShowView release],_mapShowView=nil;
    
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
    menuContainerView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:menuContainerView];
    

    _busQueryMenuView=[UIView alloc] initWithFrame:<#(CGRect)#>
    
    
    [menuContainerView addSubview:self.busQueryMenuView];
    
    _myBusZoomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.myBusZoomBtn setTitle:@"我的巴士空间" forState:UIControlStateNormal];
    [menuContainerView addSubview:self.myBusZoomBtn];
    
    [self.view addSubview:menuContainerView];
    [menuContainerView release];
    
    
}

#pragma mark - button events -
//- (void)

@end
