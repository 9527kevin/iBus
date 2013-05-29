//
//  SubLineViewController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/29/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "SubLineViewController.h"

@interface SubLineViewController ()

@property (nonatomic,retain) UIButton *leftToRightBtn;
@property (nonatomic,retain) UIButton *rightToLeftBtn;

@end

@implementation SubLineViewController

- (void)dealloc{
    [_lineInfo release],_lineInfo=nil;
    [_lineListCtrller release],_lineListCtrller=nil;
    
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
    self.view.backgroundColor=[UIColor whiteColor];
    
    _rightToLeftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightToLeftBtn.frame=CGRectMake(0, 0, MainWidth, EDGESTATION_BUTTON_HEIGHT);
    [_rightToLeftBtn setBackgroundImage:[UIImage imageNamed:@"arrow_right.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.rightToLeftBtn];
    
    _leftToRightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftToRightBtn.frame=CGRectMake(0, EDGESTATION_BUTTON_HEIGHT, MainWidth, EDGESTATION_BUTTON_HEIGHT);
    [_leftToRightBtn setBackgroundImage:[UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.leftToRightBtn];
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

@end
