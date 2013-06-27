//
//  SubLineViewController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/29/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SubLineViewController.h"

@interface SubLineViewController ()

@property (nonatomic,retain) UIView *leftToRightView;
@property (nonatomic,retain) UIView *rightToLeftView;

@end

@implementation SubLineViewController

- (void)dealloc{
    [_lineInfo release],_lineInfo=nil;
    [_lineListCtrller release],_lineListCtrller=nil;
    [_leftToRightView release],_leftToRightView=nil;
    [_rightToLeftView release],_rightToLeftView=nil;
    
    [super dealloc];
}

- (id)initWithLineInfo:(NSDictionary*)lineInfo{
    if (self=[self init]) {
        _lineInfo=[lineInfo retain];
    }
    
    return self;
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Root_View_Frame] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //left to right
    _leftToRightView=[[UIView alloc] initWithFrame:Go_View_Frame] ;
    [self.leftToRightView setTag:TAG_LEFT_TO_RIGHT];
    [self.leftToRightView setBackgroundColor:EdgeStation_View_Normal_Color];
    UIImageView *arrowToRightImgView=[[[UIImageView alloc] initWithFrame:Arrow_Frame] autorelease];
    arrowToRightImgView.image=[UIImage imageNamed:@"arrow_right.png"];
    [self.leftToRightView addSubview:arrowToRightImgView];
    
    
    //l to r 1
    UILabel *edgeStationLbl1_ltor=[[[UILabel alloc] initWithFrame:EdgeStation_Label1_Frame] autorelease ];
    [edgeStationLbl1_ltor setFont:[UIFont systemFontOfSize:EdgeStation_Label_FontSize]];
    edgeStationLbl1_ltor.backgroundColor=[UIColor clearColor];
    edgeStationLbl1_ltor.text=self.lineInfo[@"edgeStation_1"];
    [self.leftToRightView addSubview:edgeStationLbl1_ltor];
    
    //l to r 2
    UILabel *edgeStationLbl2_ltor=[[[UILabel alloc] initWithFrame:EdgeStation_Label2_Frame] autorelease ];
    [edgeStationLbl2_ltor setFont:[UIFont systemFontOfSize:EdgeStation_Label_FontSize]];
    edgeStationLbl2_ltor.backgroundColor=[UIColor clearColor];
    edgeStationLbl2_ltor.text=self.lineInfo[@"edgeStation_2"];
    [self.leftToRightView addSubview:edgeStationLbl2_ltor];
    
    [self.view addSubview:self.leftToRightView];
    
    
    //right to left
    _rightToLeftView=[[UIView alloc] initWithFrame:Back_View_Frame];
    [self.rightToLeftView setTag:TAG_RIGHT_TO_LEFT];
    [self.rightToLeftView setBackgroundColor:EdgeStation_View_Normal_Color];
    UIImageView *arrowToLeftImgView=[[[UIImageView alloc] initWithFrame:Arrow_Frame] autorelease];
    arrowToLeftImgView.image=[UIImage imageNamed:@"arrow_right.png"];
    [self.rightToLeftView addSubview:arrowToLeftImgView];
    
    
    //r to l 1
    UILabel *edgeStationLbl1_rtol=[[[UILabel alloc] initWithFrame:EdgeStation_Label1_Frame] autorelease ];
    [edgeStationLbl1_rtol setFont:[UIFont systemFontOfSize:EdgeStation_Label_FontSize]];
    edgeStationLbl1_rtol.backgroundColor=[UIColor clearColor];
    edgeStationLbl1_rtol.text=self.lineInfo[@"edgeStation_2"];
    [self.rightToLeftView addSubview:edgeStationLbl1_rtol];
    
    //r to l 2
    UILabel *edgeStationLbl2_rtol=[[[UILabel alloc] initWithFrame:EdgeStation_Label2_Frame] autorelease ];
    [edgeStationLbl2_rtol setFont:[UIFont systemFontOfSize:EdgeStation_Label_FontSize]];
    edgeStationLbl2_rtol.backgroundColor=[UIColor clearColor];
    edgeStationLbl2_rtol.text=self.lineInfo[@"edgeStation_1"];
    [self.rightToLeftView addSubview:edgeStationLbl2_rtol];
    
    [self.view addSubview:self.rightToLeftView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self registerEventsForViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)registerEventsForViews{
    [self.rightToLeftView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self.lineListCtrller action:@selector(handleGesture:)] autorelease]];
    
    [self.leftToRightView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self.lineListCtrller action:@selector(handleGesture:)] autorelease]];
}



@end
