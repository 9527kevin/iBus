//
//  AudioSettingController.m
//  iBus-iPhone
//
//  Created by yanghua on 8/4/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "AudioSettingController.h"
#import "ConfigItemDao.h"

@interface AudioSettingController ()

@property (nonatomic,retain) UIView                 *audioSwitchView;
@property (nonatomic,retain) UILabel                *audioSwitchLbl;
@property (nonatomic,retain) UISwitch               *audioSwitch;

@end

@implementation AudioSettingController

- (void)dealloc{
    [_audioSwitchView release],_audioSwitchView=nil;
    [_audioSwitchLbl release],_audioSwitchLbl=nil;
    [_audioSwitch release],_audioSwitch=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    _audioSwitchView=[[UIView alloc] initWithFrame:Audio_Switch_View_Frame];
    [self.view addSubview:self.audioSwitchView];
    
    //audio switch label
    _audioSwitchLbl=[[UILabel alloc] initWithFrame:Audio_Switch_Label_Frame];
    self.audioSwitchLbl.font=[UIFont systemFontOfSize:Audio_Switch_Label_FontSize];
    self.audioSwitchLbl.textAlignment=NSTextAlignmentLeft;
    self.audioSwitchLbl.text=@"语音开关";
    self.audioSwitchLbl.backgroundColor=[UIColor clearColor];
    [self.audioSwitchView addSubview:self.audioSwitchLbl];
    
    //audio switch
    _audioSwitch=[[UISwitch alloc] initWithFrame:Audio_Switch_Frame];
    self.audioSwitch.tintColor=[ThemeManager sharedInstance].themeColor;
    [self.audioSwitch addTarget:self
                         action:@selector(audioSwitchStateDidChanged:)
               forControlEvents:UIControlEventValueChanged];
    [self.audioSwitchView addSubview:self.audioSwitch];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"设置-语音设置";
	[self initNavLeftBackButton];
    [self setAduioSwitchState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAduioSwitchState{
    BOOL audioSwitchState=[[ConfigItemDao get:@"语音开关"] intValue] == 1 ? YES : NO;
    [self.audioSwitch setOn:audioSwitchState animated:YES];
}

- (void)audioSwitchStateDidChanged:(id)sender{
    int newValue=(int)((UISwitch*)sender).on;
    [ConfigItemDao set:[NSMutableDictionary dictionaryWithObjects:@[@"语音开关",
                        [NSNumber numberWithInt:newValue]]
                                                          forKeys:@[@"itemKey",@"itemValue"]]];
}

@end
