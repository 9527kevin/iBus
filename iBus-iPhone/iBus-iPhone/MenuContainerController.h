//
//  MenuContainer.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define Default_MenuItem_Margin_Top NavigationBarHeight+3.0f
#define Default_MenuItem_View_Width  180.0f
#define Default_MenuItem_View_Height 68.0f

#define Default_MenuItem_View_Origin_X 0.0f

#define Default_MenuItem_Label_Origin_X 60.0f
#define Default_MenuItem_Label_Origin_Y 10.0f
#define Default_MenuItem_Label_Width 140.0f
#define Default_MenuItem_Label_Height 50.0f
#define Default_MenuItem_Label_FontSize 20.0f

#define Default_MenuItem_View_Line_Splitor 1.0f

#define Default_MenuItem_ImageView_Origin_X 10.0f
#define Default_MenuItem_ImageView_Origin_Y 15.0f
#define Default_MenuItem_ImageView_Width 40.0f
#define Default_MenuItem_ImageView_Height 40.0f

#define Default_MenuItem_NormalColor ColorWithRGBA(233, 233, 233, 1)
#define Default_MenuItem_HighlightColor [UIColor grayColor]

typedef enum{
    TAG_BUSQUERY=1001,
    TAG_MAP=1002,
    TAG_BUSZOOM=1003,
    TAG_FRIENDS=1004,
    TAG_ABOUT=1005,
    TAG_SETTING=1006
}TAGS_OF_MENUITEM;


@interface MenuContainerController : BaseController

@end
