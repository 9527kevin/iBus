//
//  MenuContainer.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define Default_MenuItem_Margin_Top NavigationBarHeight
#define Default_MenuItem_View_Height (MainHeight - Default_MenuItem_Margin_Top) / 4
#define Default_MenuItem_View_Width             180.0f
//#define Default_MenuItem_View_Height 68.0f

#define Default_MenuItem_View_Origin_X          0.0f

#define Default_MenuItem_Label_FontSize         24.0f
#define Default_MenuItem_Label_Origin_X         60.0f
#define Default_MenuItem_Label_Origin_Y                                     \
((Default_MenuItem_View_Height - Default_MenuItem_Label_Height) / 2)

#define Default_MenuItem_Label_Width            140.0f
#define Default_MenuItem_Label_Height           60.0f
#define Default_MenuItem_Label_Frame CGRectMake (                           \
                                            Default_MenuItem_Label_Origin_X,\
                                            Default_MenuItem_Label_Origin_Y,\
                                            Default_MenuItem_Label_Width,   \
                                            Default_MenuItem_Label_Height   \
                                                )

#define Default_MenuItem_View_Line_Splitor      1.0f

#define Default_MenuItem_ImageView_Origin_X     10.0f
#define Default_MenuItem_ImageView_Origin_Y \
(Default_MenuItem_View_Height - Default_MenuItem_ImageView_Height) / 2

#define Default_MenuItem_ImageView_Width        40.0f
#define Default_MenuItem_ImageView_Height       40.0f
#define Default_MenuItem_ImageView_Frame CGRectMake (                       \
                                        Default_MenuItem_ImageView_Origin_X,\
                                        Default_MenuItem_ImageView_Origin_Y,\
                                        Default_MenuItem_ImageView_Width,   \
                                        Default_MenuItem_ImageView_Height   \
                                        )

#define Default_MenuItem_NormalColor ColorWithRGBA(233, 233, 233, 1)
#define Default_MenuItem_HighlightColor [UIColor grayColor]

//bus query
#define BusQuery_Menu_View_Frame CGRectMake (                               \
                                            Default_MenuItem_View_Origin_X, \
                                            Default_MenuItem_Margin_Top,    \
                                            Default_MenuItem_View_Width,    \
                                            Default_MenuItem_View_Height    \
                                            )

//bus room
#define MyBusRoom_Menu_View_Frame CGRectMake (                              \
                                            Default_MenuItem_View_Origin_X, \
Default_MenuItem_Margin_Top+1*Default_MenuItem_View_Height+1*Default_MenuItem_View_Line_Splitor,\
                                            Default_MenuItem_View_Width,    \
                                            Default_MenuItem_View_Height    \
                                             )

//about
#define About_Menu_View_Frame   CGRectMake  (                               \
                                            Default_MenuItem_View_Origin_X, \
Default_MenuItem_Margin_Top+2*Default_MenuItem_View_Height+2*Default_MenuItem_View_Line_Splitor,\
                                            Default_MenuItem_View_Width,    \
                                            Default_MenuItem_View_Height    \
                                            )

//setting
#define Setting_Menu_View_Frame CGRectMake  (                               \
                                            Default_MenuItem_View_Origin_X, \
Default_MenuItem_Margin_Top+3*Default_MenuItem_View_Height+3*Default_MenuItem_View_Line_Splitor,\
                                            Default_MenuItem_View_Width,    \
                                            Default_MenuItem_View_Height    \
                                            )

typedef enum{
    TAG_BUSQUERY        =1001,
    TAG_MAP             =1002,
    TAG_BUSZOOM         =1003,
    TAG_FRIENDS         =1004,
    TAG_ABOUT           =1005,
    TAG_SETTING         =1006
}TAGS_OF_MENUITEM;


@interface MenuContainerController : BaseController

@end
