//
//  RefreshFrequencyEditController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/18/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "RefreshFrequencyController.h"
#import "ConfigItemDao.h"

@interface RefreshFrequencyController ()

@property (nonatomic,retain) UITextField *frequencyTxtview;

@end

@implementation RefreshFrequencyController

- (void)dealloc{
    [_frequencyTxtview release],_frequencyTxtview=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    UILabel *frequencyLbl=[[[UILabel alloc] initWithFrame:Frequency_Label_Frame] autorelease];
    frequencyLbl.text=Setting_Key_RefreshFrequency;
    frequencyLbl.backgroundColor=[UIColor clearColor];
    frequencyLbl.font=[UIFont systemFontOfSize:Frequency_Label_FontSize];
    [self.view addSubview:frequencyLbl];
    
    _frequencyTxtview=[[UITextField alloc] initWithFrame:Frequency_TextView_Frame];
    self.frequencyTxtview.backgroundColor=[UIColor whiteColor];
    self.frequencyTxtview.keyboardType = UIKeyboardTypeNumberPad;
    self.frequencyTxtview.font=[UIFont systemFontOfSize:Frequency_TextView_FontSize];
    self.frequencyTxtview.delegate=self;
    [self.view addSubview:self.frequencyTxtview];
    
    //unit
    UILabel *unitLbl=[[[UILabel alloc] initWithFrame:Unit_Label_Frame] autorelease];
    unitLbl.text=@"秒/次";
    unitLbl.backgroundColor=[UIColor clearColor];
    unitLbl.font=[UIFont systemFontOfSize:Frequency_Label_FontSize];
    [self.view addSubview:unitLbl];
    
    //tip imageview and label
    UIImageView *tipImgView=[[[UIImageView alloc] initWithFrame:Tip_ImgView_Frame] autorelease];
    tipImgView.image=[UIImage imageNamed:@"tipImg.png"];
    [self.view addSubview:tipImgView];
    
    UILabel *tipLbl=[[[UILabel alloc] initWithFrame:Tip_Label_Frame] autorelease];
    tipLbl.text=@"请输入10-60之间的任一整数";
    tipLbl.textColor=[UIColor grayColor];
    tipLbl.backgroundColor=[UIColor clearColor];
    tipLbl.font=[UIFont systemFontOfSize:Tip_Label_FontSize];
    [self.view addSubview:tipLbl];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavLeftBackButton];
    [self initNavRightBarButton];
    self.navigationItem.title=@"设置-刷新频率";
    self.frequencyTxtview.text=[ConfigItemDao get:Setting_Key_RefreshFrequency];
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
    //validate
    NSString *numStr=self.frequencyTxtview.text;
    if (!numStr || [numStr isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"刷新频率不能为空"];
        return;
    }
    int num=[numStr intValue];
    if (num<10 || num>60) {
        [SVProgressHUD showErrorWithStatus:@"刷新频率超出正常范围"];
        return;
    }
    
    //update
    
    NSMutableDictionary *keyValuePair=[NSMutableDictionary dictionary];
    [keyValuePair setObject:Setting_Key_RefreshFrequency forKey:@"itemKey"];
    [keyValuePair setObject:numStr forKey:@"itemValue"];
    [ConfigItemDao set:keyValuePair];
    
    NSString *newValue=[ConfigItemDao get:Setting_Key_RefreshFrequency];
    if (newValue && [newValue isEqualToString:numStr]) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [self.frequencyTxtview resignFirstResponder];
    }else{
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }
}

#pragma mark - UITextField delegate -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (range.location >= 2)
        return NO;
    return YES;
}


@end
