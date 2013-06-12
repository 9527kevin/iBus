//
//  LineDynamicStateController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/7/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define Toptip_Label_Width 70.0f
#define Toptip_Label_Height 30.0f
#define Toptip_Label_FontSize 14.0f

#define Toptip_StationList_Label_Origin_X 70.0f
#define Toptip_StationList_Label_Origin_Y 0.0f

#define Toptip_Distance_Label_Origin_X MainWidth - Toptip_Distance_Label_Width - 5.0f
#define Toptip_Distance_Label_Origin_Y 0.0f
#define Toptip_Distance_Label_Width 65.0f

#define Toptip_CountDownTime_Label_Origin_X \
Toptip_Distance_Label_Origin_X - Toptip_CountDownTime_Label_Width -5.0f
#define Toptip_CountDownTime_Label_Origin_Y 0.0f
#define Toptip_CountDownTime_Label_Width 55.0f

//the label of distance and countdown time showing in the view
#define TipInContainerView_Label_Height 20.0f
#define TipInContainerView_Label_FontSize 12.0f
#define TipInContainerView_Label_TextColor ColorWithRGBA(249, 154, 10, 1);

#define Dynamic_State_ContainerView_Origin_X 0
#define Dynamic_State_ContainerView_Origin_Y 30.0f
#define Dynamic_State_ContainerView_Width MainWidth
#define Dynamic_State_ContainerView_Height \
MainHeight - Toptip_Label_Height - BottomTip_Label_Height - NavigationBarHeight

#define Station_Label_StartIndex 1000
#define Station_Label_Margin (Dynamic_State_ContainerView_Height - (Station_Label_Height * 8)) / 9
#define Station_Label_Origin_X 5.0f
#define Station_Label_Width MainWidth * 0.5 -20.0f - Station_Label_Origin_X
#define Station_Label_Height 30.0f
#define Station_Label_FontSize 16.0f

#define StationEntryMark_ImageView_Margin Station_Label_Margin + 1.5f
#define StationEntryMark_ImageView_Origin_X Arrow_ImageView_Origin_X + Arrow_ImageView_Width
#define StationEntryMark_ImageView_Width 25.0f
#define StationEntryMark_ImageView_Height 25.0f

#define BottomTip_Label_Origin_X 5.0f
#define BottomTip_Label_Width MainWidth
#define BottomTip_Label_Height 30.0f
#define BottomTip_Label_Origin_Y MainHeight - Toptip_Label_Height - NavigationBarHeight
#define BottomTip_Label_FontSize 16.0f

#define BottomNextTime_Label_Origin_X BottomTip_Label_Width + 5.0f
#define BottomNextTime_Label_Origin_Y BottomTip_Label_Origin_Y
#define BottomNextTime_Label_Width MainWidth - BottomNextTime_Label_Origin_X
#define BottomNextTime_Label_Height BottomTip_Label_Height
#define BottomNextTime_Label_FontSize 16.0f 

#define Arrow_ImageView_Origin_X MainWidth / 2 - Station_Label_Margin
#define Arrow_ImageView_Origin_Y 0.0f 
#define Arrow_ImageView_Width 27.0f
#define Arrow_ImageView_Height Dynamic_State_ContainerView_Height

@interface LineDynamicStateController : BaseController

@property (nonatomic,assign) int stationNo;
@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *lineId;
@property (nonatomic,copy) NSString *stationName;

@end
