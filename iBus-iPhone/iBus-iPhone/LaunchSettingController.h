//
//  LaunchSettingController.h
//  iBus-iPhone
//
//  Created by yanghua on 7/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define LaunchAnomation_Segment_FontSize                18.0f
#define LaunchAnomation_Segment_Origin_X                10.0f
#define LaunchAnomation_Segment_Origin_Y                20.0f
#define LaunchAnomation_Segment_Width \
MainWidth - LaunchAnomation_Segment_Origin_X * 2

#define LaunchAnomation_Segment_Height                  45.0f
#define LaunchAnomation_Segment_Frame   CGRectMake  (                       \
                                        LaunchAnomation_Segment_Origin_X,   \
                                        LaunchAnomation_Segment_Origin_Y,   \
                                        LaunchAnomation_Segment_Width,      \
                                        LaunchAnomation_Segment_Height      \
                                                    )

@interface LaunchSettingController : BaseController

@end
