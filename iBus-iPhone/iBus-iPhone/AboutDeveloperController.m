//
//  AboutDeveloperController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "AboutDeveloperController.h"


@interface AboutDeveloperController ()

@end

@implementation AboutDeveloperController

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"关于开发者";
	[self initNavLeftBackButton];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NIAttributedLabel delegate -
- (void)layoutSubviews{
    NIAttributedLabel* label = [[NIAttributedLabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.autoresizingMask = UIViewAutoresizingFlexibleDimensions;
    label.frame = CGRectInset(self.view.bounds, 3.0f, 0) ;
    label.font=[UIFont systemFontOfSize:14];
    label.delegate = self;
    label.autoDetectLinks = YES;
    label.backgroundColor=Default_TableView_BackgroundColor;
    
    // Turn on all available data detectors. This includes phone numbers, email addresses, and
    // addresses.
    label.dataDetectorTypes = NSTextCheckingAllSystemTypes;
    
    label.text =
    @"\n==============关于开发者=============="
    @"\n新浪微博: @yanghua_kobe"
    @"\n项目开源地址: https://github.com/yanghua/iBus"
    @"\n任何问题请联系: yanghua1127@gmail.com"
    @"\n服务可用性测试: "
    @"\nhttp://112.2.33.3:7106/wap/line.do?command=toLn"
    @"\n\n===========关于图标与图片处理==========="
    @"\n新浪微博: @一个汉字两个字节"
    @"\n个人博客: http://forback.com"
    @"\n\n===========关于数据接口剥离============="
    @"\n新浪微博: @人可的地盘"
    @"\n\n=================声明================="
    @"\n该接口的归属权属于南京通用公司!"
    @"\n本应用的源码完全开源，开发时间完全来自于本人工作之余的碎片时间，所以还有待进一步完善。"
    @"随时欢迎有兴趣的人fork并push有价值的request。"
    @"\n\n再次声明:本应用的源码只供学习和交流使用，任何人不得将其用于商业目的，否则后果自负！";
    
    //add links
    [label addLink:[NSURL URLWithString:@"http://weibo.com/u/1958166695"]
             range:[label.text rangeOfString:@"@yanghua_kobe"]];
    
    [label addLink:[NSURL URLWithString:@"http://weibo.com/537025345"]
             range:[label.text rangeOfString:@"@一个汉字两个字节"]];
    
    [label addLink:[NSURL URLWithString:@"http://weibo.com/renkezone"]
             range:[label.text rangeOfString:@"@人可的地盘"]];
    
    
    [self.view addSubview:label];
}


- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point{
    switch ([result resultType]) {
        case NSTextCheckingTypeLink:
        {
            NSString *selectedStr=[result.URL absoluteString];
            
            if ([selectedStr rangeOfString:@"mailto"].length!=0) {      //mail
                [self sendEmail];
            }else if ([selectedStr rangeOfString:@"http"].length!=0){   //url
                NIWebController *webCtrller=[[[NIWebController alloc] initWithURL:[NSURL URLWithString:selectedStr]] autorelease];
                [self.navigationController pushViewController:webCtrller animated:YES];
            }
            
        }
            break;
                        
        default:
            break;
    }
}

- (void)sendEmail{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate=self;
        [mailer setToRecipients:[[[NSArray alloc]initWithObjects:@"yanghua1127@gmail.com", nil]autorelease]];
        [mailer setSubject:@"建议与反馈"];
        [mailer setMessageBody:@"" isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
        [mailer release];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请先在系统中设置你的邮件帐户:设置->邮件、通讯录、日历->添加帐户"];
    }
    
}

#pragma mark - mail delegate methods -
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [SVProgressHUD showErrorWithStatus:@"取消发送"];
            break;
            
        case MFMailComposeResultSaved:
            [SVProgressHUD showSuccessWithStatus:@"邮件已保存"];
            break;
            
        case MFMailComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"邮件发送成功"];
            break;
            
        case MFMailComposeResultFailed:
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"邮件发送失败:%@",[error localizedDescription]]];
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
