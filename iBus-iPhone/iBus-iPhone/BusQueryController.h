//
//  BusQueryController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define QuerySelect_Button_FontSize             16.0f
#define QuerySelect_Button_Origin_X             20.0f
#define QuerySelect_Button_Origin_Y             30.0f
#define QuerySelect_Button_Width                100.0f
#define QuerySelect_Button_Height               35.0f
#define QuerySelect_Button_Frame CGRectMake (                               \
                                                QuerySelect_Button_Origin_X,\
                                                QuerySelect_Button_Origin_Y,\
                                                QuerySelect_Button_Width,   \
                                                QuerySelect_Button_Height   \
                                            )

#define Query_TextField_FontSize                16.0f
#define Query_TextField_Origin_X \
(QuerySelect_Button_Origin_X + QuerySelect_Button_Width + 7.0f)

#define Query_TextField_Origin_Y QuerySelect_Button_Origin_Y
#define Query_TextField_Width \
(MainWidth - Query_TextField_Origin_X -20.0f)

#define Query_TextField_Height                  QuerySelect_Button_Height
#define Query_TextField_Frame CGRectMake    (                               \
                                                Query_TextField_Origin_X,   \
                                                Query_TextField_Origin_Y,   \
                                                Query_TextField_Width,      \
                                                Query_TextField_Height      \
                                            )

#define Query_Button_FontSize                   22.0f
#define Query_Button_Origin_X  (MainWidth - Query_Button_Width) / 2

#define Query_Button_Origin_Y \
(QuerySelect_Button_Origin_X + QuerySelect_Button_Height + 30.0f)

#define Query_Button_Width                      280.0f
#define Query_Button_Height                     35.0f
#define Query_Button_Frame CGRectMake   (                                   \
                                            Query_Button_Origin_X,          \
                                            Query_Button_Origin_Y,          \
                                            Query_Button_Width,             \
                                            Query_Button_Height             \
                                        )


#define Special_Character_RegExpression         @"([`~!@#$^&*()=|%{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？])"

#define Tip_Label_FontSize                      14.0f
#define Tip_Label_Origin_X                      7.0f
#define Tip_Label_Origin_Y \
(MainHeight - NavigationBarHeight - Tip_Label_Height)

#define Tip_Label_Width \
MainWidth - (2 * Tip_Label_Origin_X)

#define Tip_Label_Height                        220.0f
#define Tip_Label_Frame CGRectMake  (                                       \
                                        Tip_Label_Origin_X,                 \
                                        Tip_Label_Origin_Y,                 \
                                        Tip_Label_Width,                    \
                                        Tip_Label_Height                    \
                                    )

@interface BusQueryController : BaseController
<
UITextFieldDelegate
>

@end
