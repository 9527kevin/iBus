//
//  MenuContainer.m
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "MenuContainerController.h"
#import "FetchLineInfoOperation.h"

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
    
	[self registerTapEventsForMenuItems];
    
    //fetch basic data
    [self fetchLineInfoAsync];
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
    

    //公交查询
    _busQueryMenuView=[[UIView alloc] initWithFrame:CGRectMake(Default_MenuItem_View_Origin_X, Default_MenuItem_Margin_Top, Default_MenuItem_View_Width, Default_MenuItem_View_Height)];
    self.busQueryMenuView.backgroundColor=[UIColor grayColor];
    [menuContainerView addSubview:self.busQueryMenuView];
    
    UILabel *busQueryLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Default_MenuItem_Label_Origin_X, Default_MenuItem_Label_Origin_Y, Default_MenuItem_Label_Width, Default_MenuItem_Label_Height)] autorelease];
    busQueryLbl.text=@"公交查询";
    busQueryLbl.backgroundColor=[UIColor grayColor];
    busQueryLbl.font=[UIFont systemFontOfSize:Default_MenuItem_Label_FontSize];
    [self.busQueryMenuView addSubview:busQueryLbl];
    
    //查看地图
    _mapShowView=[[UIView alloc] initWithFrame:CGRectMake(Default_MenuItem_View_Origin_X, Default_MenuItem_Margin_Top+Default_MenuItem_View_Height+Default_MenuItem_View_Line_Splitor, Default_MenuItem_View_Width, Default_MenuItem_View_Height)];
    self.mapShowView.backgroundColor=[UIColor grayColor];
    [menuContainerView addSubview:self.mapShowView];
    
    UILabel *mapShowLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Default_MenuItem_Label_Origin_X, Default_MenuItem_Label_Origin_Y, Default_MenuItem_Label_Width, Default_MenuItem_Label_Height)] autorelease];
    mapShowLbl.text=@"查看地图";
    mapShowLbl.backgroundColor=[UIColor grayColor];
    mapShowLbl.font=[UIFont systemFontOfSize:Default_MenuItem_Label_FontSize];
    [self.mapShowView addSubview:mapShowLbl];
    
    //我的巴士空间
    _myBusZoomView=[[UIView alloc] initWithFrame:CGRectMake(Default_MenuItem_View_Origin_X, Default_MenuItem_Margin_Top+2*Default_MenuItem_View_Height+2*Default_MenuItem_View_Line_Splitor, Default_MenuItem_View_Width, Default_MenuItem_View_Height)];
    self.myBusZoomView.backgroundColor=[UIColor grayColor];
    [menuContainerView addSubview:self.myBusZoomView];
    
    UILabel *myBusZoomLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Default_MenuItem_Label_Origin_X, Default_MenuItem_Label_Origin_Y, Default_MenuItem_Label_Width, Default_MenuItem_Label_Height)] autorelease];
    myBusZoomLbl.text=@"巴士空间";
    myBusZoomLbl.backgroundColor=[UIColor grayColor];
    myBusZoomLbl.font=[UIFont systemFontOfSize:Default_MenuItem_Label_FontSize];
    [self.myBusZoomView addSubview:myBusZoomLbl];
    
    //附近的人
    _findFriendView=[[UIView alloc] initWithFrame:CGRectMake(Default_MenuItem_View_Origin_X, Default_MenuItem_Margin_Top+3*Default_MenuItem_View_Height+3*Default_MenuItem_View_Line_Splitor, Default_MenuItem_View_Width, Default_MenuItem_View_Height)];
    self.findFriendView.backgroundColor=[UIColor grayColor];
    [menuContainerView addSubview:self.findFriendView];
    
    UILabel *findFriendLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Default_MenuItem_Label_Origin_X, Default_MenuItem_Label_Origin_Y, Default_MenuItem_Label_Width, Default_MenuItem_Label_Height)] autorelease];
    findFriendLbl.text=@"附近的人";
    findFriendLbl.backgroundColor=[UIColor grayColor];
    findFriendLbl.font=[UIFont systemFontOfSize:Default_MenuItem_Label_FontSize];
    [self.findFriendView addSubview:findFriendLbl];
    
    //关于
    _aboutView=[[UIView alloc] initWithFrame:CGRectMake(Default_MenuItem_View_Origin_X, Default_MenuItem_Margin_Top+4*Default_MenuItem_View_Height+4*Default_MenuItem_View_Line_Splitor, Default_MenuItem_View_Width, Default_MenuItem_View_Height)];
    self.aboutView.backgroundColor=[UIColor grayColor];
    [menuContainerView addSubview:self.aboutView];
    
    UILabel *aboutLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Default_MenuItem_Label_Origin_X, Default_MenuItem_Label_Origin_Y, Default_MenuItem_Label_Width, Default_MenuItem_Label_Height)] autorelease];
    aboutLbl.text=@"关于应用";
    aboutLbl.backgroundColor=[UIColor grayColor];
    aboutLbl.font=[UIFont systemFontOfSize:Default_MenuItem_Label_FontSize];
    [self.aboutView addSubview:aboutLbl];
    
    
    [self.view addSubview:menuContainerView];
    [menuContainerView release];
    
}

- (void)registerTapEventsForMenuItems{
    
}

- (void)fetchLineInfoAsync{
#warning TODO:check is inited
    FetchLineInfoOperation *fenchLineInfoOperation=[[[FetchLineInfoOperation alloc] init] autorelease];
    [((AppDelegate*)appDelegateObj).operationQueueCenter addOperation:fenchLineInfoOperation];
}


@end
