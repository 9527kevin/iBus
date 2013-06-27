//
//  RefreshFrequencyEditController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/18/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define Frequency_Label_FontSize                15.0f
#define Frequency_Label_Origin_X                5.0f
#define Frequency_Label_Origin_Y                20.0f
#define Frequency_Label_Width                   60.0f
#define Frequency_Label_Height                  30.0f
#define Frequency_Label_Frame CGRectMake(                                   \
                                            Frequency_Label_Origin_X,       \
                                            Frequency_Label_Origin_Y,       \
                                            Frequency_Label_Width,          \
                                            Frequency_Label_Height          \
                                        )

#define Unit_Label_Width                        40.0f
#define Unit_Label_Height Frequency_Label_Height
#define Unit_Label_Origin_X (MainWidth - Unit_Label_Width - 5.0f)
#define Unit_Label_Origin_Y Frequency_Label_Origin_Y
#define Unit_Label_Frame CGRectMake (                                       \
                                        Unit_Label_Origin_X,                \
                                        Unit_Label_Origin_Y,                \
                                        Unit_Label_Width,                   \
                                        Unit_Label_Height                   \
                                    )


#define Frequency_TextView_FontSize             20.0f
#define Frequency_TextView_Origin_X                                         \
(Frequency_Label_Origin_X + Frequency_Label_Width + 5.0f)

#define Frequency_TextView_Origin_Y Frequency_Label_Origin_Y + 2.0f
#define Frequency_TextView_Width                                            \
(Unit_Label_Origin_X - (Frequency_TextView_Origin_X) - 5.0f)

#define Frequency_TextView_Height               25.0f
#define Frequency_TextView_Frame CGRectMake(                                \
                                                Frequency_TextView_Origin_X,\
                                                Frequency_TextView_Origin_Y,\
                                                Frequency_TextView_Width,   \
                                                Frequency_TextView_Height   \
                                            )


#define Tip_ImgView_Origin_X Frequency_TextView_Origin_X
#define Tip_ImgView_Origin_Y                                                \
(Frequency_Label_Origin_Y + Frequency_Label_Height +3.0f)

#define Tip_ImgView_Width                       20.0f
#define Tip_ImgView_Height                      20.0f
#define Tip_ImgView_Frame CGRectMake  (                                     \
                                        Tip_ImgView_Origin_X,               \
                                        Tip_ImgView_Origin_Y,               \
                                        Tip_ImgView_Width,                  \
                                        Tip_ImgView_Height                  \
                                      )  

#define Tip_Label_FontSize                      13.0f
#define Tip_Label_Origin_X                                                  \
((Tip_ImgView_Origin_X) + Tip_ImgView_Width + 2.0f) 

#define Tip_Label_Origin_Y Tip_ImgView_Origin_Y 
#define Tip_Label_Width MainWidth 
#define Tip_Label_Height                        20.0f
#define Tip_Label_Frame CGRectMake  (                                       \
                                        Tip_Label_Origin_X,                 \
                                        Tip_Label_Origin_Y,                 \
                                        Tip_Label_Width,                    \
                                        Tip_Label_Height                    \
                                    )



@interface RefreshFrequencyController : BaseController
<
UITextFieldDelegate
>

@end
