//
//  RefreshFrequencyEditController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/18/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "RefreshFrequencyController.h"
#import "ConfigItemDao.h"
#import "NYSliderPopover.h"

@interface RefreshFrequencyController ()

@property (nonatomic,retain) NYSliderPopover        *frequencySlider;

@end

@implementation RefreshFrequencyController

- (void)dealloc{
    [_frequencySlider release],_frequencySlider=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    //unit
    UILabel *unitLbl=[[[UILabel alloc] initWithFrame:Unit_Label_Frame] autorelease];
    unitLbl.text=@"秒/次";
    unitLbl.backgroundColor=[UIColor clearColor];
    unitLbl.font=[UIFont systemFontOfSize:Unit_Label_FontSize];
    [self.view addSubview:unitLbl];
    
    _frequencySlider=[[NYSliderPopover alloc] initWithFrame:Frequency_Slider_Frame];
    [self.frequencySlider setThumbTintColor:[ThemeManager sharedInstance].themeColor];
    [self.frequencySlider setMinimumTrackTintColor:[ThemeManager sharedInstance].themeColor];
    [self.frequencySlider addTarget:self
                        action:@selector(sliderValueChanged:)
              forControlEvents:UIControlEventValueChanged];
    self.frequencySlider.minimumValue=10;
    self.frequencySlider.maximumValue=60;
    
    [self.view addSubview:self.frequencySlider];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavLeftBackButton];
    [self initNavRightBarButton];
    self.navigationItem.title=@"设置-刷新频率";
    NSString *refreshFrequencyStr=[ConfigItemDao get:Setting_Key_RefreshFrequency];
    self.frequencySlider.value=[refreshFrequencyStr intValue];
    self.frequencySlider.popover.textLabel.text=refreshFrequencyStr;
    [self.frequencySlider showPopoverAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavRightBarButton{
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake(0, 0, 30, 30);
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"submitBtn.png"]
                         forState:UIControlStateNormal];
    [submitBtn addTarget:self
                  action:@selector(handleRightBarButton:)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *submitBarBtnItem=[[[UIBarButtonItem alloc] initWithCustomView:submitBtn] autorelease];
    
    self.navigationItem.rightBarButtonItem = submitBarBtnItem;
}

- (void)handleRightBarButton:(id)sender{
    
    //update
    NSMutableDictionary *keyValuePair=[NSMutableDictionary dictionary];
    [keyValuePair setObject:Setting_Key_RefreshFrequency
                     forKey:@"itemKey"];
    [keyValuePair setObject:[NSNumber numberWithInt:(int)self.frequencySlider.value]
                     forKey:@"itemValue"];
    [ConfigItemDao set:keyValuePair];
    
    NSString *newValue=[ConfigItemDao get:Setting_Key_RefreshFrequency];
    if (newValue && ([newValue intValue] == (int)self.frequencySlider.value)) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }
}

#pragma mark - frequency slider -
- (void)sliderValueChanged:(id)sender
{
    [self updateSliderPopoverText];
}

- (void)updateSliderPopoverText
{
    self.frequencySlider.popover.textLabel.text = [NSString stringWithFormat:@"%d",
                                                        (int)self.frequencySlider.value];
}



@end
