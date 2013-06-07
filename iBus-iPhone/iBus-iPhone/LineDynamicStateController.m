//
//  LineDynamicStateController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/7/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineDynamicStateController.h"

@interface LineDynamicStateController ()

@property (nonatomic,retain) UIView *containerView;

@end

@implementation LineDynamicStateController

- (void)dealloc{
    [_identifier release],_identifier=nil;
    [_lineId release],_lineId=nil;
    [_containerView release],_containerView=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initDynamicStateContainerView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //send request to get dynamic info
    
    [self layoutDynamicStationSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)initDynamicStateContainerView{
    _containerView=[[UIView alloc] initWithFrame:CGRectMake(Dynamic_State_ContainerView_Origin_X, Dynamic_State_ContainerView_Origin_Y, Dynamic_State_ContainerView_Width, Dynamic_State_ContainerView_Height)];
    self.containerView.backgroundColor=ColorWithRGBA(245, 245, 245, 1);
    [self.view addSubview:self.containerView];
}

- (void)layoutDynamicStationSubviews{
    for (int i=0; i<8; i++) {
        //s1
        UILabel *stationLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Station_Label_Origin_X, Station_Label_Margin+Station_Label_Height*i, Station_Label_Width, Station_Label_Height)] autorelease];
        stationLbl.textAlignment=NSTextAlignmentRight;
        stationLbl.backgroundColor=[UIColor clearColor];
        stationLbl.textColor=[UIColor blueColor];
        stationLbl.font=[UIFont systemFontOfSize:Station_Label_FontSize];
        stationLbl.text=@"石马";
        
        [self.containerView addSubview:stationLbl];
        
#warning add station mark image
    }
}

@end
