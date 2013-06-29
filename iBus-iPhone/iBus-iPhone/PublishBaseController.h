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
#define At_Button_Origin_Y              4.0f
#define At_Button_Width                 25.0f
#define At_Button_Height                25.0f
#define At_Button_Frame CGRectMake  (                                   \
                                        At_Button_Origin_X,             \
                                        At_Button_Origin_Y,             \
                                        At_Button_Width,                \
                                        At_Button_Height                \
                                    )

#define Tip_View_Height                 30.0f

#define Tool_View_Height                34.0f

#define CheckBox_Button_Origin_X    50.0f
#define CheckBox_Button_Origin_Y    6.0f
#define CheckBox_Button_Width       20.0f
#define CheckBox_Button_Height      20.0f
#define CheckBox_Button_Frame   CGRectMake  (                           \
                                        CheckBox_Button_Origin_X,       \
                                        CheckBox_Button_Origin_Y,       \
                                        CheckBox_Button_Width,          \
                                        CheckBox_Button_Height          \
                                            )

#define Imgtip_Label_FontSize 12.0f
#define Imgtip_Label_Origin_X                                           \
CheckBox_Button_Origin_X + CheckBox_Button_Width + 3.0f

#define Imgtip_Label_Origin_Y CheckBox_Button_Origin_Y

#define Imgtip_Label_Width MainWidth - CheckBox_Button_Origin_X
#define Imgtip_Label_Height CheckBox_Button_Height
#define Imgtip_Label_Frame CGRectMake   (                               \
                                            Imgtip_Label_Origin_X,      \
                                            Imgtip_Label_Origin_Y,      \
                                            Imgtip_Label_Width,         \
                                            Imgtip_Label_Height         \
                                        )

#define Default_Fill_Txt                                                \
@"我正在使用 #江宁掌上公交(iPhone版)# 应用，它支持实时查询公交的"                \
"位置，收藏经常乘坐的线路、经常上下的站点。方便又省时，快去 App Store 搜索 [江宁掌上公交] 下载吧！"

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

@property (nonatomic,assign) BOOL                   imageSwitch;


@end

@protocol PublishBaseControllerDelegate <NSObject>

@optional

- (void)atBtn_handle:(id)sender;

- (void)publishBtn_handle:(id)sender;

@end
