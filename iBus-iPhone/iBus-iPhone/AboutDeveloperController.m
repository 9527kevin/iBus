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
    
    NIAttributedLabel* label = [[NIAttributedLabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.autoresizingMask = UIViewAutoresizingFlexibleDimensions;
    label.frame = CGRectInset(self.view.bounds, 3.0f, 0) ;
    label.font = [UIFont fontWithName:@"Optima-Regular" size:14];
    label.delegate = self;
    label.autoDetectLinks = YES;
    label.backgroundColor=Default_TableView_BackgroundColor;
    
    // Turn on all available data detectors. This includes phone numbers, email addresses, and
    // addresses.
    label.dataDetectorTypes = NSTextCheckingAllSystemTypes;
    
    label.text =
    @"\n-----------------------关于开发者-----------------------"
    @"\n新浪微博: @yanghua_kobe"
    @"\n项目开源地址: https://github.com/yanghua/iBus"
    @"\n任何问题请联系: yanghua1127@gmail.com"
    @"\n\n-----------------关于图标与图片处理-----------------"
    @"\n新浪微博: @一个汉字两个字节"
    @"\n\n-------------------关于数据接口剥离-------------------"
    @"\n新浪微博: @口袋贵金属"
    @"\n\n---------------------------声明---------------------------"
    @"\n该接口的归属权属于南京通用公司!开发本应用的初衷是为了练习技术以及给本人和有需求在江宁地区查询公交实时位置的人提供一些方便。"
    @"为了证明本人无任何想要通过此应用谋取商业利益的想法，本应用的源码完全开源。"
    @"本应用的开发时间完全来自于本人工作之余的碎片时间，所以还有待进一步完善。"
    @"随时欢迎有兴趣的人fork并push有价值的request。"
    @"\n\n再次声明:本应用的源码只供学习和交流使用，任何人不得将其用于商业目的，否则后果自负！";
    
    [self.view addSubview:label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"关于开发者";
	[self initNavLeftBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NIAttributedLabel delegate -
- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point{
    switch ([result resultType]) {
        case NSTextCheckingTypeLink:
        {
            NSString *selectedStr=[result.URL absoluteString];
            
            
            if ([selectedStr rangeOfString:@"mailto"].length!=0) {      //mail
                
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

@end
