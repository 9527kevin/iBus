//
//  LineDynamicStateController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/7/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

#define Dynamic_State_ContainerView_Origin_X 0
#define Dynamic_State_ContainerView_Origin_Y 30.0f
#define Dynamic_State_ContainerView_Width MainWidth
#define Dynamic_State_ContainerView_Height MainHeight * 0.75

#define Station_Label_Margin 10.0f
#define Station_Label_Origin_X 5.0f
#define Station_Label_Width MainWidth * 0.5 -20.0f - Station_Label_Origin_X
#define Station_Label_Height 40.0f
#define Station_Label_FontSize 16.0f

#define StationEntryMark_ImageView_Margin 10.0f
#define StationEntryMark_ImageView_Origin_X MainWidth * 0.5+20.0f
#define StationEntryMark_ImageView_Width MainWidth * 0.5 -20.0f - Station_Label_Origin_X
#define StationEntryMark_ImageView_Height 40.0f

@interface LineDynamicStateController : BaseController

@property (nonatomic,assign) NSInteger stationNo;
@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *lineId;

@end
