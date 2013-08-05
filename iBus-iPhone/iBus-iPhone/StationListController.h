//
//  StationListControllerViewController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ELTableViewController.h"
#import "StationListCell.h"

#define TopTip_View_Origin_X                        0.0f
#define TopTip_View_Origin_Y                        0.0f
#define TopTip_View_Width                           MainWidth
#define TopTip_View_Height                          30.0f
#define TopTip_View_Frame   CGRectMake  (                                   \
                                            TopTip_View_Origin_X,           \
                                            TopTip_View_Origin_Y,           \
                                            TopTip_View_Width,              \
                                            TopTip_View_Height              \
                                        )

#define LineScheduleTip_Label_FontSize              14.0f
#define LineScheduleTip_Label_Origin_X              5.0f
#define LineScheduleTip_Label_Origin_Y              0.0f
#define LineScheduleTip_Label_Width                 MainWidth /2
#define LineScheduleTip_Label_Height                TopTip_View_Height
#define LineScheduleTip_Label_Frame CGRectMake (                            \
                                            LineScheduleTip_Label_Origin_X, \
                                            LineScheduleTip_Label_Origin_Y, \
                                            LineScheduleTip_Label_Width,    \
                                            LineScheduleTip_Label_Height    \
                                                )

#define LineSchedule_FontSize  LineScheduleTip_Label_FontSize
#define LineSchedule_Label_Origin_X                  MainWidth /2
#define LineSchedule_Label_Origin_Y                  0.0f
#define LineSchedule_Label_Width                     (MainWidth /2) - 5.0f
#define LineSchedule_Label_Height                    TopTip_View_Height
#define LineSchedule_Label_Frame    CGRectMake  (                           \
                                                LineSchedule_Label_Origin_X,\
                                                LineSchedule_Label_Origin_Y,\
                                                LineSchedule_Label_Width,   \
                                                LineSchedule_Label_Height   \
                                                )

@interface StationListController : ELTableViewController
<
StationListCellDelegate
>

@property (nonatomic,copy) NSString *lineId;
@property (nonatomic,copy) NSString *lineName;
@property (nonatomic,copy) NSString *identifier;

@end
