//
//  AboutController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define AppIcon_ImageView_Origin_X (MainWidth - AppIcon_ImageView_Width) / 2
#define AppIcon_ImageView_Origin_Y 20.0f
#define AppIcon_ImageView_Width 114.0f
#define AppIcon_ImageView_Height 114.0f
#define AppIcon_ImageView_Frame CGRectMake  (   AppIcon_ImageView_Origin_X, \
                                                AppIcon_ImageView_Origin_Y, \
                                                AppIcon_ImageView_Width,    \
                                                AppIcon_ImageView_Height    \
                                            )

#define AppName_Label_Origin_X (MainWidth - AppName_Label_Width) / 2
#define AppName_Label_Origin_Y 135.0f
#define AppName_Label_Width 240.0f
#define AppName_Label_Height 45.0f
#define AppName_Label_FontSize 33.0f
#define AppName_Label_Frame CGRectMake (                                    \
                                            AppName_Label_Origin_X,         \
                                            AppName_Label_Origin_Y,         \
                                            AppName_Label_Width,            \
                                            AppName_Label_Height            \
                                        )


#define Button_Margin_H 1.0f

#define Developer_Button_Origin_X (MainWidth - Developer_Button_Width) / 2
#define Developer_Button_Origin_Y 190.0f
#define Developer_Button_Width 240.0f
#define Developer_Button_Height 40.0f
#define Developer_Button_Frame CGRectMake (                                 \
                                            Developer_Button_Origin_X,      \
                                            Developer_Button_Origin_Y,      \
                                            Developer_Button_Width,         \
                                            Developer_Button_Height         \
                                          )


#define Share_Button_Origin_X Developer_Button_Origin_X
#define Share_Button_Origin_Y                                               \
Developer_Button_Origin_Y + ( Developer_Button_Height + Button_Margin_H ) * 1
#define Share_Button_Width Developer_Button_Width
#define Share_Button_Height Developer_Button_Height
#define Share_Button_Frame CGRectMake (                                     \
                                            Share_Button_Origin_X,          \
                                            Share_Button_Origin_Y,          \
                                            Share_Button_Width,             \
                                            Share_Button_Height             \
                                      )


#define Comment_Button_Origin_X Developer_Button_Origin_X
#define Comment_Button_Origin_Y                                             \
Developer_Button_Origin_Y + ( Developer_Button_Height + Button_Margin_H ) * 2
#define Comment_Button_Width Developer_Button_Width
#define Comment_Button_Height Developer_Button_Height
#define Comment_Button_Frame CGRectMake (                                   \
                                            Comment_Button_Origin_X,        \
                                            Comment_Button_Origin_Y,        \
                                            Comment_Button_Width,           \
                                            Comment_Button_Height           \
                                        )

#define CopyRight_Label_Origin_X 0
#define CopyRight_Label_Origin_Y                                            \
MainHeight - NavigationBarHeight - (CopyRight_Label_Height + RightReserved_Label_Height)
#define CopyRight_Label_Width MainWidth
#define CopyRight_Label_Height 20.0f
#define CopyRight_Label_Frame CGRectMake  (                                 \
                                            CopyRight_Label_Origin_X,       \
                                            CopyRight_Label_Origin_Y,       \
                                            CopyRight_Label_Width,          \
                                            CopyRight_Label_Height          \
                                          )

#define CopyRight_Label_FontSize 13.0f

#define RightReserved_Label_Origin_X 0
#define RightReserved_Label_Origin_Y                                        \
MainHeight - NavigationBarHeight - RightReserved_Label_Height
#define RightReserved_Label_Width MainWidth
#define RightReserved_Label_Height 20.0f
#define RightReserved_Label_Frame CGRectMake  (                             \
                                        RightReserved_Label_Origin_X,       \
                                        RightReserved_Label_Origin_Y,       \
                                        RightReserved_Label_Width,          \
                                        RightReserved_Label_Height          \
                                              )

#define RightReserved_Label_FontSize 13.0f


typedef enum {
    Tag_Developer,
    Tag_Share,
    Tag_Comment
}ENUM_About_Tags;

@interface AboutController : BaseController
<
UIActionSheetDelegate
>

@end
