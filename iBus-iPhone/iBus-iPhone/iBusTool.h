//
//  iBusTool.h
//  iBus-iPhone
//
//  Created by yanghua on 6/24/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GlobalInstance [iBusTool GetGlobalInstance]

@interface iBusTool : NSObject

//获得Global的单例对象
+(iBusTool*)GetGlobalInstance;


#pragma mark - get many kinds of height -
//获取特定大小的文本高度
-(CGFloat)getHeightWithText:(NSString*)text
                   fontSize:(CGFloat)fontSize
                 constraint:(CGSize)cSize
                  minHeight:(CGFloat)mHeight;

//获取特定大小的文本高度
-(CGFloat)getHeightWithFontText:(NSString*)text
                           font:(UIFont*)_font
                     constraint:(CGSize)cSize
                      minHeight:(CGFloat)mHeight;

//获取特定大小的文本高度带换行形式
-(CGFloat)getHeightWithText:(NSString*)text
                   fontSize:(CGFloat)fontSize
              lineBreakMode:(UILineBreakMode)lbm
                 constraint:(CGSize)cSize
                  minHeight:(CGFloat)mHeight;

//获取特定大小的文本寬度
-(CGFloat)getWidthWithText:(NSString*)text
                      font:(UIFont*)font;

#pragma mark - Date -
//日期格式的字符串转换为时间格式
-(NSDate*)NSStringDateToNSDate:(NSString*)dateString;

//日期格式的字符串转换为时间格式
-(NSDate*)NSStringDateToNSDate:(NSString*)dateString
                 withFormatter:(NSDateFormatter*)formatter;

//日期转化为日期格式的字符串
-(NSString*)NSDateToNSString:(NSDate*)date;

//日期转化为日期格式的字符串
-(NSString*)NSDateToNSString:(NSDate*)date
               withFormatter:(NSDateFormatter*)formatter;

//日期字符串的格式化
-(NSString*)FormatWithDateString:(NSString*)dateString
             withSourceFormatter:(NSDateFormatter*)sourceFormatter
              forResultFormatter:(NSDateFormatter*)resultFormatter;

#pragma mark -
#pragma mark UIWebView
//改變網頁樣式    --直接讓UIWebView加載
-(NSString*)ChangeStyleWithHtml:(NSString*)htmlTxt
                     fontFamily:(NSString*)family
                       fontSize:(CGFloat)size
                      fontColor:(NSString*)color;

//改變字體顏色      通過UIWebView執行js
-(NSString*)ChangeFontColorWithHtml:(NSString*)color;

//改變字體大小      通過UIWebView執行js
-(NSString*)ChangeFontSizeWithHtml:(CGFloat)size;

//清除UIWebView的背景色
-(void)clearWebViewBackground:(UIWebView*)webView;

#pragma mark -
#pragma mark Network status check
//是否开启WWAN网络
-(BOOL)isEnable3G;

//是否开启wifi上网方式
-(BOOL)isEnableWiFi;

//网络是否开启
-(BOOL)isEnableNetwork;

//發送郵件
-(void)sendEmailTo:(NSString*)to
       withSubject:(NSString*)subject
          withBody:(NSString*)body;

//获取公网IP
- (NSString*)getOuterNetworkIPAddress;

#pragma mark - Image handle -
//生成原比例的缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image
                                       size:(CGSize)asize;

#pragma mark - UI handle -
//状态栏显示完成提示信息
-(void)showOverlayMsg:(NSString*)msg
          andDuration:(NSTimeInterval)duration
           andOverlay:(MTStatusBarOverlay*)overlay;

//状态栏显示错误提示信息
-(void)showOverlayErrorMsg:(NSString*)msg
               andDuration:(NSTimeInterval)duration
                andOverlay:(MTStatusBarOverlay*)overlay;

//动画效果：从底部出现
-(CATransition*)AnimationFromBottomToTop;

//移除子视图
-(void)removeChilds:(UIView*)view;

//去除UITableView多余cell的分隔线
- (void)setExtraCellLineHidden:(UITableView *)tableView;

#pragma mark - text -
//判断一个字符是不是中文
- (BOOL)isChineseCharacter:(int)charWithASII;

#pragma mark - text to speech -
//朗读语音
- (void)iFlySpeech:(NSString*)text
         withAppID:(NSString*)appId;

@end
