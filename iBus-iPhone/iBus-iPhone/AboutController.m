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
#import "SharedToSinaWeiboController.h"
#import "SharedToWeixinController.h"
#import "Appirater.h"

@interface AboutController ()

@property (nonatomic,retain) UIActionSheet *shareActionSheet;

@end

@implementation AboutController

- (void)dealloc{
    [_shareActionSheet release],_shareActionSheet=nil;
    
    [super dealloc];
}

- (void)loadView{
    //app icon
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    UIImageView *appIconImgView=[[[UIImageView alloc] initWithFrame:AppIcon_ImageView_Frame] autorelease];
    appIconImgView.image=[UIImage imageNamed:@"icon@2x.png"];
    [self.view addSubview:appIconImgView];
    
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
    [developerBtn addTarget:self
                     action:@selector(Buttons_TouchDown:)
           forControlEvents:UIControlEventTouchDown];
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
    [commentBtn addTarget:self
                 action:@selector(Buttons_TouchUpInside:)
       forControlEvents:UIControlEventTouchUpInside];
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
    
    //share
    _shareActionSheet=[[UIActionSheet alloc] initWithTitle:@"分享应用"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"分享到新浪微博",@"分享到微信", nil];
    [self.view addSubview:self.shareActionSheet];
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
    btn.backgroundColor=Default_Theme_Color;
    UIViewController *viewController=nil;
    switch (btn.tag) {
            
        case Tag_Developer:
        {
            AboutDeveloperController *aboutDevCtrller=[[[AboutDeveloperController alloc] init] autorelease];
            viewController=aboutDevCtrller;
        }
            break;
            
        case Tag_Share:
        {
            [self.shareActionSheet showInView:self.view];
            return;
        }
            break;
            
        case Tag_Comment:
        {
            [Appirater userDidSignificantEvent:YES];
            return;
        }
        default:
            break;
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)Buttons_TouchDown:(id)sender{
    UIButton *btn=(UIButton*)sender;
    btn.backgroundColor=Default_TableView_BackgroundColor;
}

#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    ShareController *shareCtrller=nil;
    switch (buttonIndex) {
        case 0:
        {
            shareCtrller=[[[SharedToSinaWeiboController alloc] init] autorelease];
        }
            break;
            
        case 1:
        {
            shareCtrller=[[[SharedToWeixinController alloc] init] autorelease];
        }
            break;
            
        default:
            break;
    }
    
    if (shareCtrller) {
        UINavigationController *shareNavCtrller=[[[UINavigationController alloc] initWithRootViewController:shareCtrller] autorelease];
        [self.navigationController presentViewController:shareNavCtrller animated:YES completion:nil];
    }
}


@end
