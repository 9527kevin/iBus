//
//  RefreshFrequencyEditController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/18/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"


#define Unit_Label_FontSize                     15.0f
#define Unit_Label_Width                        40.0f
#define Unit_Label_Height                       30.0f
#define Unit_Label_Origin_X (MainWidth - Unit_Label_Width - 5.0f)
#define Unit_Label_Origin_Y                     41.0f
#define Unit_Label_Frame CGRectMake (                                       \
                                        Unit_Label_Origin_X,                \
                                        Unit_Label_Origin_Y,                \
                                        Unit_Label_Width,                   \
                                        Unit_Label_Height                   \
                                    )



#define Frequency_Slider_Origin_X               10.0f
#define Frequency_Slider_Origin_Y               40.0f
#define Frequency_Slider_Width  MainWidth - Unit_Label_Width - 17.0f
#define Frequency_Slider_Height                 30.0f

#define Frequency_Slider_Frame CGRectMake   (                               \
                                                Frequency_Slider_Origin_X,  \
                                                Frequency_Slider_Origin_Y,  \
                                                Frequency_Slider_Width,     \
                                                Frequency_Slider_Height     \
                                            )



@interface RefreshFrequencyController : BaseController

@end
