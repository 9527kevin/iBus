//
//  LaunchSettingController.m
//  iBus-iPhone
//
//  Created by yanghua on 7/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LaunchSettingController.h"
#import "ConfigItemDao.h"

@interface LaunchSettingController ()

@property (nonatomic,retain) UISegmentedControl             *animationSegment;

@end

@implementation LaunchSettingController

- (void)dealloc{
    [_animationSegment release],_animationSegment=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    _animationSegment=[[UISegmentedControl alloc] initWithFrame:LaunchAnomation_Segment_Frame];
    
    [self.animationSegment setBackgroundColor:[UIColor clearColor]];
    [self.animationSegment setTintColor:[ThemeManager sharedInstance].themeColor];
    self.animationSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.animationSegment insertSegmentWithTitle:@"翻页" atIndex:0 animated:YES];
    [self.animationSegment insertSegmentWithTitle:@"淡出" atIndex:0 animated:YES];
    [self.animationSegment insertSegmentWithTitle:@"飞出" atIndex:0 animated:YES];
    [self.animationSegment setSelectedSegmentIndex:0];

    UIFont *font = [UIFont boldSystemFontOfSize:LaunchAnomation_Segment_FontSize];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [self.animationSegment setTitleTextAttributes:attributes
                                         forState:UIControlStateNormal];
    [self.animationSegment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:self.animationSegment];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavLeftBackButton];
    self.navigationItem.title=@"设置-启动动画";

    int currentAnimationVal=[[ConfigItemDao get:@"启动动画"] intValue];
    [self.animationSegment setSelectedSegmentIndex:currentAnimationVal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private methods -
- (void)segmentValueChanged:(UISegmentedControl *)seg{
    int newValue=seg.selectedSegmentIndex;
    [ConfigItemDao set:[NSMutableDictionary dictionaryWithObjects:
                                @[@"启动动画",[NSNumber numberWithInt:newValue]]
                            forKeys:@[@"itemKey",@"itemValue"]]];
}

@end
