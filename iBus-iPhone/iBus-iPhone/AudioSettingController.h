//
//  AudioSettingController.h
//  iBus-iPhone
//
//  Created by yanghua on 8/4/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define Audio_Switch_View_Origin_X                          0.0f
#define Audio_Switch_View_Origin_Y                          0.0f
#define Audio_Switch_View_Width                             MainWidth
#define Audio_Switch_View_Height                            60.0f
#define Audio_Switch_View_Frame     CGRectMake  (                           \
                                                Audio_Switch_View_Origin_X, \
                                                Audio_Switch_View_Origin_Y, \
                                                Audio_Switch_View_Width,    \
                                                Audio_Switch_View_Height    \
                                                )



#define Audio_Switch_Label_FontSize                         22.0f
#define Audio_Switch_Label_Origin_X                         10.0f
#define Audio_Switch_Label_Origin_Y                         11.0f
#define Audio_Switch_Label_Width                            MainWidth / 2
#define Audio_Switch_Label_Height                           40.0f
#define Audio_Switch_Label_Frame    CGRectMake  (                           \
                                                Audio_Switch_Label_Origin_X,\
                                                Audio_Switch_Label_Origin_Y,\
                                                Audio_Switch_Label_Width,   \
                                                Audio_Switch_Label_Height   \
                                                )


#define Audio_Switch_Origin_X (MainWidth - Audio_Switch_Width - 20.0f)
#define Audio_Switch_Origin_Y Audio_Switch_Label_Origin_Y + 10.0f
#define Audio_Switch_Width                                  70.0f
#define Audio_Switch_Height   Audio_Switch_Label_Height
#define Audio_Switch_Frame  CGRectMake  (                                   \
                                            Audio_Switch_Origin_X,          \
                                            Audio_Switch_Origin_Y,          \
                                            Audio_Switch_Width,             \
                                            Audio_Switch_Height             \
                                        )


@interface AudioSettingController : BaseController

@end
