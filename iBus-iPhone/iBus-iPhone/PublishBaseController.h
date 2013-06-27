//
//  PublishBaseController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/22/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"
#import "UIPlaceHolderTextView.h"
#import "ClickableLabel.h"

#define STRLENGTH                       140              //可输入的字符长度
#define Publish_TextView_FontSize       18
#define Publish_TextView_Original_X     0.0f
#define Publish_TextView_Original_Y     0.0f
#define Publish_TextView_Width          MainWidth
#define Publish_TextView_Height         135.0f
#define Publish_TextView_Frame CGRectMake (                             \
                                            Publish_TextView_Original_X,\
                                            Publish_TextView_Original_Y,\
                                            Publish_TextView_Width,     \
                                            Publish_TextView_Height     \
                                          )

#define At_Button_Origin_X              10.0f
#define At_Button_Origin_Y              0.0f
#define At_Button_Width                 25.0f
#define At_Button_Height                25.0f
#define At_Button_Frame CGRectMake  (                                   \
                                        At_Button_Origin_X,             \
                                        At_Button_Origin_Y,             \
                                        At_Button_Width,                \
                                        At_Button_Height                \
                                    )

#define Default_Fill_Txt                                                \
@"我正在使用 #江宁掌上公交(iPhone版)# 应用，它支持实时查询公交的"                \
"位置，收藏经常乘坐的线路、经常上下的站点。方便又省时，快去下载吧！"

@protocol PublishBaseControllerDelegate;

@interface PublishBaseController : BaseController
<
UITextViewDelegate,
ClickEventDelegate,
UIActionSheetDelegate
>

@property (nonatomic,copy)   NSString               *publishingContent;
@property (nonatomic,retain) UIPlaceHolderTextView  *publishTxtView;
@property (nonatomic,assign) id<PublishBaseControllerDelegate> delegate;
@property (nonatomic,retain) NSArray                *photoArray;
@property (nonatomic,retain) NSMutableArray         *followedList;

@property (nonatomic,retain) UIButton               *atBtn;


@end

@protocol PublishBaseControllerDelegate <NSObject>

@optional

- (void)atBtn_handle:(id)sender;

- (void)publishBtn_handle:(id)sender;

@end
