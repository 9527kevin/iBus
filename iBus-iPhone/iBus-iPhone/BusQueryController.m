//
//  BusQueryController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BusQueryController.h"
#import "LineListController.h"
#import "SIAlertView.h"
#import "LineDao.h"

typedef enum {
    BY_LINENAME         =0,
    BY_STATIONNAME      =1,
    BY_EXCHANGE         =2
}ENUM_QueryType;

@interface BusQueryController ()

@property (nonatomic,retain) UIButton               *querySelectBtn;
@property (nonatomic,retain) UITextField            *queryTxtField;
@property (nonatomic,retain) UIButton               *queryBtn;
@property (nonatomic,retain) UILabel                *tipLbl;

@property (nonatomic,retain) NSMutableArray         *queryDataSource;
@property (nonatomic,assign) ENUM_QueryType         queryType;

@end

@implementation BusQueryController

- (void)dealloc{
    [_queryTxtField release],_queryTxtField=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=Default_TableView_BackgroundColor;
    
    _querySelectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
//    UIImage *popWindowImg=[UIImage imageNamed:@"popWindow.png"];
//    UIImage *bgImg=[UIImage imageWithPureColor:self.themeColor
//                                       andSize:QuerySelect_Button_Frame.size];
//    
//    UIImage *megredQuerySelectBGImg=[UIImage mergeImage:popWindowImg
//                                                toImage:bgImg
//                                                 atZoom:CGRectMake(3, 7, 20, 20)];
//    
//    //test
//    NSData *imgData=UIImagePNGRepresentation(megredQuerySelectBGImg);
//    [imgData writeToFile:[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"ghi.png"] atomically:YES];
    
    
    self.querySelectBtn.frame=QuerySelect_Button_Frame;
    [self.querySelectBtn setTitle:@"按线路" forState:UIControlStateNormal];
    [self.querySelectBtn.titleLabel setFont:[UIFont systemFontOfSize:QuerySelect_Button_FontSize]];
    self.querySelectBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.querySelectBtn addTarget:self
                            action:@selector(menuBtn_touchUpInside:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.querySelectBtn];
    
    _queryTxtField=[[UITextField alloc] initWithFrame:Query_TextField_Frame];
    self.queryTxtField.placeholder=@"";
    self.queryTxtField.font=[UIFont systemFontOfSize:Query_TextField_FontSize];
    [self.queryTxtField setAdjustsFontSizeToFitWidth:YES];
    self.queryTxtField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    self.queryTxtField.delegate=self;
    self.queryTxtField.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.queryTxtField];
    
    _queryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
//    UIImage *incomingImg=[UIImage imageNamed:@"searchBtn.png"];
//    
//    UIImage *originalImg=[UIImage imageWithPureColor:self.themeColor
//                                             andSize:Query_Button_Frame.size];
//        
//    UIImage *mergedBackgroundImg=[UIImage mergeImage:incomingImg
//                                             toImage:originalImg
//                                              atZoom:CGRectMake(70, 5, 25, 25)];
//    
//    NSData *imgData_1=UIImagePNGRepresentation(mergedBackgroundImg);
//    [imgData_1 writeToFile:[PATH_OF_DOCUMENT stringByAppendingPathComponent:@"lmn.png"] atomically:YES];
//    NSLog(@"aaaaaaaa%@",PATH_OF_DOCUMENT);
    
    
    
    self.queryBtn.frame=Query_Button_Frame;
    [self.queryBtn setTitle:@"查  询" forState:UIControlStateNormal];
    [self.queryBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:Query_Button_FontSize]];
    
    [self.queryBtn addTarget:self
                      action:@selector(queryButton_touchUpInside:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryBtn];
    
    //tip
    _tipLbl=[[[UILabel alloc] initWithFrame:Tip_Label_Frame] autorelease];
    self.tipLbl.numberOfLines=0;
    self.tipLbl.textColor=[UIColor grayColor];
    self.tipLbl.backgroundColor=[UIColor clearColor];
    self.tipLbl.font=[UIFont systemFontOfSize:Tip_Label_FontSize];
    self.tipLbl.text=   @"查询提示:\n"
                        "1、按线路查询:查询匹配线路名称的线路\n"
                        "2、按站点查询:查询匹配站点名称的线路\n"
                        "3、按换乘查询:查询形式为 (从) XXX (去/ /到) XXX，其中XXX表示站点名称，"
                        "两个站点之间以 去、空格、到 进行区分，无括号。\n"
                        "示例一：安德门 托乐嘉\n"
                        "示例二：安德 到 托乐嘉 (支持模糊查询)\n"
                        "示例三：从安德门 去 托乐 (支持模糊查询)\n";
    
    [self.view addSubview:self.tipLbl];
}

- (void)configUIAppearance{
    [self.querySelectBtn setBackgroundImage:[[ThemeManager sharedInstance]  themedImageWithName:@"choseBtn.png"]
                                   forState:UIControlStateNormal];
    
    [self.queryBtn setBackgroundImage:[[ThemeManager sharedInstance]  themedImageWithName:@"searchBtn.png"]
                             forState:UIControlStateNormal];
    
    
    [super configUIAppearance];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.queryType=BY_LINENAME;             //init query type
    self.queryTxtField.placeholder=@"请输入线路名称";
	[self initNavigationController];
    [self initNavRightBarButton];
    self.navigationItem.title=@"公交查询";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods -
- (void)initNavRightBarButton{
    UIButton *lineGuideBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [lineGuideBtn  setBackgroundImage:[UIImage imageNamed:@"lineListGuide.png"]
                             forState:UIControlStateNormal];
    lineGuideBtn.frame=CGRectMake(0, 0, 30.0f, 30.0f);
    [lineGuideBtn addTarget:self
                     action:@selector(rightNavBarButton_touchUpInside:)
           forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *lineGuideBarBtn=[[[UIBarButtonItem alloc] initWithCustomView:lineGuideBtn] autorelease];
    self.navigationItem.rightBarButtonItem=lineGuideBarBtn;
}

- (void)rightNavBarButton_touchUpInside:(id)sender{
    LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
    [self.navigationController pushViewController:lineListCtrller
                                         animated:YES];
}

- (void)menuBtn_touchUpInside:(id)sender{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"查询类型"
                                                     andMessage:@"请选择以下的查询类型"];
    [alertView addButtonWithTitle:@"按线路查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [self.querySelectBtn setTitle:@"按线路"
                                                   forState:UIControlStateNormal];
                              self.queryTxtField.placeholder=@"请输入线路名称";
                              self.queryType=BY_LINENAME;
                          }];
    [alertView addButtonWithTitle:@"按站点查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [self.querySelectBtn setTitle:@"按站点"
                                                   forState:UIControlStateNormal];
                              self.queryTxtField.placeholder=@"请输入站点名称";
                              self.queryType=BY_STATIONNAME;
                          }];
    [alertView addButtonWithTitle:@"按换乘查询"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [self.querySelectBtn setTitle:@"按换乘"
                                                   forState:UIControlStateNormal];
                              self.queryTxtField.placeholder=@"示例:从安德门到托乐嘉";
                              self.queryType=BY_EXCHANGE;
                          }];
    
    alertView.titleColor = [UIColor grayColor];
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
    };
    
    alertView.didShowHandler = ^(SIAlertView *alertView) {
    };
    
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
    };
    
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
    };
    
    [alertView show];
    
}

- (void)queryButton_touchUpInside:(id)sender{
    if (!self.queryTxtField.text || [[self.queryTxtField.text trim] isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"查询内容不可为空!"];
        return;
    }
    
    NSString *queryStr=[self securityCheck:self.queryTxtField.text];
    
    if (!queryStr || [[queryStr trim] isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"不得输入非法字符!"];
        return;
    }
    
    //clear
    self.queryDataSource=nil;
        
    switch (self.queryType) {
        case BY_LINENAME:
            [self queryLineWithLineName:queryStr];
            break;
            
        case BY_STATIONNAME:
            [self queryLineWithStationName:queryStr];
            break;
            
        case BY_EXCHANGE:
            [self queryLineWithStationExchange:queryStr];
            break;
            
        default:
            break;
    }
    
    if (!self.queryDataSource || self.queryDataSource.count==0) {
        [SVProgressHUD showErrorWithStatus:@"无匹配结果!"];
        return;
    }
    
    LineListController *lineListCtrller=[[[LineListController alloc] init] autorelease];
    lineListCtrller.dataSource=self.queryDataSource;
    [self.navigationController pushViewController:lineListCtrller animated:YES];
}


- (void)queryLineWithLineName:(NSString*)queryStr{
    self.queryDataSource=[LineDao queryLineWithLineName:queryStr];
}

- (void)queryLineWithStationName:(NSString*)queryStr{
    self.queryDataSource=[LineDao queryLineWithStationName:queryStr];
}

- (void)queryLineWithStationExchange:(NSString*)queryStr{
    //key word:去 、 到 、从、‘ ’
    //trimStart and trimEnd and replace 
    queryStr=[[[[queryStr trim] replaceAll:@"从" with:@""]
                                replaceAll:@"去" with:@" "]
                                replaceAll:@"到" with:@" "];
    
    //replace multi backspace to single backspace
    NSArray* words = [queryStr componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    if (words.count!=2) {
        [SVProgressHUD showErrorWithStatus:@"查询信息不合法!"];
        return;
    }
    
    NSString *startStation=words[0];
    NSString *endStation=words[1];
    
    self.queryDataSource=[LineDao queryLineWithStartStation:startStation
                                              andEndStation:endStation];
}



/**
 *	@brief	合法性检查
 *
 *	@param 	str 	original str
 *
 *	@return	checked or replaced str
 */
- (NSString*)securityCheck:(NSString*)str
{
    NSRegularExpression *regularExp=[NSRegularExpression
                                     regularExpressionWithPattern:Special_Character_RegExpression
                                     options:NSRegularExpressionCaseInsensitive
                                     error:nil];
    
    NSUInteger count =[regularExp numberOfMatchesInString:str
                                                  options:NSMatchingReportProgress
                                                    range:NSMakeRange(0, [str length])];
    
    //replace
    if(count>0){
        NSMutableString *mutableContent = [NSMutableString stringWithString:str];
        [regularExp replaceMatchesInString:mutableContent
                                   options:NSMatchingReportCompletion
                                     range:NSMakeRange(0, [str length])
                              withTemplate:@""];
        
        return mutableContent;
    }else{
        return str;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIView *touchedView=[(UITouch*)[touches anyObject] view];
    if ([touchedView isKindOfClass:[UITableView class]]) {
        return;
    }else{
        [self.queryTxtField resignFirstResponder];
    }
}


@end
