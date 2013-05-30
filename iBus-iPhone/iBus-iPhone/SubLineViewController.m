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
    self.view=[[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 60.0f)] autorelease];
    self.view.backgroundColor=[UIColor blackColor];
    
    //left to right
    _leftToRightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, EDGESTATION_VIEW_HEIGHT)];
    [self.leftToRightView setTag:TAG_LEFT_TO_RIGHT];
    [self.leftToRightView setBackgroundColor:EDGESTATION_VIEW_NORMAL_COLOR];
    UIImageView *arrowToRightImgView=[[UIImageView alloc] initWithFrame:CGRectMake(ARROW_ORIGIN_X, ARROW_ORIGIN_Y, ARROW_WIDTH, ARROW_HEIGHT)];
    arrowToRightImgView.image=[UIImage imageNamed:@"arrow_right.png"];
    [self.leftToRightView addSubview:arrowToRightImgView];
    
    
    //l to r 1
    UILabel *edgeStationLbl1_ltor=[[[UILabel alloc] initWithFrame:CGRectMake(EDGESTATION_LABEL1_ORIGIN_X, EDGESTATION_LABEL1_ORIGIN_Y, EDGESTATION_LABEL_WIDTH, EDGESTATION_VIEW_HEIGHT)] autorelease ];
    [edgeStationLbl1_ltor setFont:[UIFont systemFontOfSize:EDGESTATION_LABEL_FONTSIZE]];
    edgeStationLbl1_ltor.backgroundColor=[UIColor clearColor];
    edgeStationLbl1_ltor.text=self.lineInfo[@"edgeStation_1"];
    [self.leftToRightView addSubview:edgeStationLbl1_ltor];
    
    //l to r 2
    UILabel *edgeStationLbl2_ltor=[[[UILabel alloc] initWithFrame:CGRectMake(EDGESTATION_LABEL2_ORIGIN_X, EDGESTATION_LABEL2_ORIGIN_Y, EDGESTATION_LABEL_WIDTH, EDGESTATION_VIEW_HEIGHT)] autorelease ];
    [edgeStationLbl2_ltor setFont:[UIFont systemFontOfSize:EDGESTATION_LABEL_FONTSIZE]];
    edgeStationLbl2_ltor.backgroundColor=[UIColor clearColor];
    edgeStationLbl2_ltor.text=self.lineInfo[@"edgeStation_2"];
    [self.leftToRightView addSubview:edgeStationLbl2_ltor];
    
    [self.view addSubview:self.leftToRightView];
    
    
    //right to left
    _rightToLeftView=[[UIView alloc] initWithFrame:CGRectMake(0, EDGESTATION_VIEW_HEIGHT+1, MainWidth, EDGESTATION_VIEW_HEIGHT)];
    [self.leftToRightView setTag:TAG_RIGHT_TO_LEFT];
    [self.rightToLeftView setBackgroundColor:EDGESTATION_VIEW_NORMAL_COLOR];
    UIImageView *arrowToLeftImgView=[[UIImageView alloc] initWithFrame:CGRectMake(ARROW_ORIGIN_X, ARROW_ORIGIN_Y, ARROW_WIDTH, ARROW_HEIGHT)];
    arrowToLeftImgView.image=[UIImage imageNamed:@"arrow_left.png"];
    [self.rightToLeftView addSubview:arrowToLeftImgView];
    
    
    //r to l 1
    UILabel *edgeStationLbl1_rtol=[[[UILabel alloc] initWithFrame:CGRectMake(EDGESTATION_LABEL1_ORIGIN_X, EDGESTATION_LABEL1_ORIGIN_Y, EDGESTATION_LABEL_WIDTH, EDGESTATION_VIEW_HEIGHT)] autorelease ];
    [edgeStationLbl1_rtol setFont:[UIFont systemFontOfSize:EDGESTATION_LABEL_FONTSIZE]];
    edgeStationLbl1_rtol.backgroundColor=[UIColor clearColor];
    edgeStationLbl1_rtol.text=self.lineInfo[@"edgeStation_2"];
    [self.rightToLeftView addSubview:edgeStationLbl1_rtol];
    
    //r to l 2
    UILabel *edgeStationLbl2_rtol=[[[UILabel alloc] initWithFrame:CGRectMake(EDGESTATION_LABEL2_ORIGIN_X, EDGESTATION_LABEL2_ORIGIN_Y, EDGESTATION_LABEL_WIDTH, EDGESTATION_VIEW_HEIGHT)] autorelease ];
    [edgeStationLbl2_rtol setFont:[UIFont systemFontOfSize:EDGESTATION_LABEL_FONTSIZE]];
    edgeStationLbl2_rtol.backgroundColor=[UIColor clearColor];
    edgeStationLbl2_rtol.text=self.lineInfo[@"edgeStation_1"];
    [self.rightToLeftView addSubview:edgeStationLbl2_rtol];
    
    
    [self.view addSubview:self.rightToLeftView];
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
- (void)registerEventsForViews{
    [self.rightToLeftView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)] autorelease]];
    
    [self.leftToRightView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)] autorelease]];
}

- (void)handleGesture:(UISwipeGestureRecognizer*)gestureRecognizer{
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
        [gestureRecognizer view].backgroundColor=EDGESTATION_VIEW_HIGHLIGHT_COLOR;
    }else if(gestureRecognizer.state==UIGestureRecognizerStateEnded){
        [gestureRecognizer view].backgroundColor=EDGESTATION_VIEW_HIGHLIGHT_COLOR;
    }else if (gestureRecognizer.state==UIGestureRecognizerStateCancelled){
        [gestureRecognizer view].backgroundColor=EDGESTATION_VIEW_NORMAL_COLOR;
    }
    
#warning TODO
    switch (gestureRecognizer.view.tag) {
        case TAG_LEFT_TO_RIGHT:
            
            break;
            
        case TAG_RIGHT_TO_LEFT:
            
            break;
            
        default:
            break;
    }
    
}

@end
