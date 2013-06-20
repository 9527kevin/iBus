//
//  AboutController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "AboutController.h"
#import "NIAttributedLabel.h"
#import "AboutDeveloperController.h"
#import "ShareController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    //app name
    NIAttributedLabel *appNameLbl=[[[NIAttributedLabel alloc] initWithFrame:AppName_Label_Frame] autorelease];
    appNameLbl.text=@"iBus For iPhone";
    appNameLbl.font=[UIFont systemFontOfSize:AppName_Label_FontSize];
    appNameLbl.strokeWidth=3.0f;
    appNameLbl.backgroundColor=[UIColor clearColor];
    appNameLbl.strokeColor=Default_Theme_Color;
    
    [self.view addSubview:appNameLbl];
    
    //关于开发者
    UIButton *developerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    developerBtn.backgroundColor=Default_Theme_Color;
    developerBtn.frame=Developer_Button_Frame;
    [developerBtn setTitle:@"  关于开发者" forState:UIControlStateNormal];
    developerBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    developerBtn.tag=Tag_Developer;
    [developerBtn addTarget:self
                     action:@selector(Buttons_TouchUpInside:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:developerBtn];
    
    //分享
    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.backgroundColor=Default_Theme_Color;
    shareBtn.frame=Share_Button_Frame;
    [shareBtn setTitle:@"  与更多的人分享" forState:UIControlStateNormal];
    shareBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    shareBtn.tag=Tag_Share;
    [shareBtn addTarget:self
                 action:@selector(Buttons_TouchUpInside:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    //评分
    UIButton *commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    commentBtn.backgroundColor=Default_Theme_Color;
    commentBtn.frame=Comment_Button_Frame;
    [commentBtn setTitle:@"  给应用评分" forState:UIControlStateNormal];
    commentBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    commentBtn.tag=Tag_Comment;
    [self.view addSubview:commentBtn];
    
    //copy right and reserved
    UILabel *copyRightLbl=[[[UILabel alloc] initWithFrame:CopyRight_Label_Frame] autorelease];
    copyRightLbl.textAlignment=NSTextAlignmentCenter;
    copyRightLbl.backgroundColor=[UIColor clearColor];
    copyRightLbl.textColor=[UIColor grayColor];
    copyRightLbl.font=[UIFont systemFontOfSize:CopyRight_Label_FontSize];
    copyRightLbl.text=@"Copyright (c) 2013 yanghua.";
    [self.view addSubview:copyRightLbl];
    
    UILabel *rightReserved=[[[UILabel alloc] initWithFrame:RightReserved_Label_Frame]
                            autorelease];
    rightReserved.textAlignment=NSTextAlignmentCenter;
    rightReserved.backgroundColor=[UIColor clearColor];
    rightReserved.textColor=[UIColor grayColor];
    rightReserved.font=[UIFont systemFontOfSize:RightReserved_Label_FontSize];
    rightReserved.text=@"All rights reserved.";
    [self.view addSubview:rightReserved];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title=@"关于";
    [self initNavigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)Buttons_TouchUpInside:(id)sender{
    UIButton *btn=(UIButton*)sender;
    UIViewController *viewController=nil;
    switch (btn.tag) {
            
        case Tag_Developer:
        {
            AboutDeveloperController *aboutDevCtrller=[[[AboutDeveloperController alloc] init] autorelease];
            viewController=aboutDevCtrller;
        }
            break;
            
        case Tag_Share:
            
            break;
            
        case Tag_Comment:
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


@end
