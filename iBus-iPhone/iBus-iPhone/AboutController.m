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

@property (nonatomic,retain) UIActionSheet              *shareActionSheet;
@property (nonatomic,retain) NIAttributedLabel          *appNameLbl;
@property (nonatomic,retain) UIButton                   *commentBtn;
@property (nonatomic,retain) UIButton                   *shareBtn;
@property (nonatomic,retain) UIButton                   *developerBtn;

@end

@implementation AboutController

- (void)dealloc{
    [_shareActionSheet release],_shareActionSheet=nil;
    [_appNameLbl release],_appNameLbl=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    //app icon
    UIImageView *appIconImgView=[[[UIImageView alloc] initWithFrame:AppIcon_ImageView_Frame] autorelease];
    appIconImgView.image=[UIImage imageNamed:@"IconForAbout.png"];
    [self.view addSubview:appIconImgView];
    
    //app name
    _appNameLbl=[[NIAttributedLabel alloc] initWithFrame:AppName_Label_Frame];
    self.appNameLbl.text=@"iBus For iPhone";
    self.appNameLbl.font=[UIFont systemFontOfSize:AppName_Label_FontSize];
    self.appNameLbl.strokeWidth=3.0f;
    self.appNameLbl.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:self.appNameLbl];
    
    //关于开发者
    _developerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.developerBtn.frame=Developer_Button_Frame;
    [self.developerBtn setTitle:@"  关于开发者" forState:UIControlStateNormal];
    self.developerBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.developerBtn.tag=Tag_Developer;
    [self.developerBtn addTarget:self
                     action:@selector(Buttons_TouchUpInside:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.developerBtn];
    
    //分享
    _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn.frame=Share_Button_Frame;
    [self.shareBtn setTitle:@"  与更多的人分享"
              forState:UIControlStateNormal];
    self.shareBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.shareBtn.tag=Tag_Share;
    [self.shareBtn addTarget:self
                 action:@selector(Buttons_TouchUpInside:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareBtn];
    
    //评分
    _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.frame=Comment_Button_Frame;
    [self.commentBtn setTitle:@"  给应用评分"
                forState:UIControlStateNormal];
    self.commentBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.commentBtn.tag=Tag_Comment;
    [self.commentBtn addTarget:self
                 action:@selector(Buttons_TouchUpInside:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentBtn];
    
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
                                         otherButtonTitles: @"分享到新浪微博",
                                                            @"分享给微信好友",
                                                            @"分享到微信朋友圈", nil];
    [self.view addSubview:self.shareActionSheet];
}

- (void)configUIAppearance{
    self.appNameLbl.strokeColor=[[ThemeManager sharedInstance] themeColor];
    [self.commentBtn setBackgroundImage:[[ThemeManager sharedInstance] themedImageWithName:@"aboutBtnBG.png"]
                               forState:UIControlStateNormal];
    [self.commentBtn setBackgroundImage:[[ThemeManager sharedInstance] themedImageWithName:@"aboutBtnBG_hl.png"]
                               forState:UIControlStateHighlighted];
    
    [self.shareBtn setBackgroundImage:[[ThemeManager sharedInstance] themedImageWithName:@"aboutBtnBG.png"]
                             forState:UIControlStateNormal];
    [self.shareBtn setBackgroundImage:[[ThemeManager sharedInstance] themedImageWithName:@"aboutBtnBG_hl.png"]
                             forState:UIControlStateHighlighted];
    
    [self.developerBtn setBackgroundImage:[[ThemeManager sharedInstance] themedImageWithName:@"aboutBtnBG.png"] forState:UIControlStateNormal];
    [self.developerBtn setBackgroundImage:[[ThemeManager sharedInstance] themedImageWithName:@"aboutBtnBG_hl.png"] forState:UIControlStateHighlighted];
    
    [super configUIAppearance];
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
    btn.backgroundColor=[[ThemeManager sharedInstance] themeColor];
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
            [Appirater rateApp];
            return;
        }
        default:
            break;
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark - UIActionSheet delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    ShareController *shareCtrller=nil;
    switch (buttonIndex) {
        case 0:                                         //新浪微博
        {
            shareCtrller=[[[SharedToSinaWeiboController alloc] init] autorelease];
        }
            break;
            
        case 1:                                         //微信好友
        {
            SharedToWeixinController *tmpCtrller=[[[SharedToWeixinController alloc] init] autorelease];
            tmpCtrller.scene=WXSceneSession;
            shareCtrller =tmpCtrller;
        }
            break;
            
        case 2:                                         //微信朋友圈
        {
            SharedToWeixinController *tmpCtrller=[[[SharedToWeixinController alloc] init] autorelease];
            tmpCtrller.scene=WXSceneTimeline;
            shareCtrller =tmpCtrller;
        }
            
        default:
            break;
    }
    
    if (shareCtrller) {
        UINavigationController *shareNavCtrller=[[[UINavigationController alloc] initWithRootViewController:shareCtrller] autorelease];
        [self.navigationController presentViewController:shareNavCtrller
                                                animated:YES
                                              completion:nil];
    }
}


@end
