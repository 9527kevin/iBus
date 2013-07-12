//
//  BusDynamicStateOfLineController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"

//normal
#define ToolBar_Button_Normal_Origin_X                      20.0f
#define ToolBar_Button_Normal_Origin_Y  MainHeight - NavigationBarHeight - 70.0f
#define ToolBar_Button_Normal_Width                         30.0f
#define ToolBar_Button_Normal_Height                        30.0f
#define ToolBar_Button_Normal_Frame CGRectMake  (                           \
                                            ToolBar_Button_Normal_Origin_X, \
                                            ToolBar_Button_Normal_Origin_Y, \
                                            ToolBar_Button_Normal_Width,    \
                                            ToolBar_Button_Normal_Height    \
                                                )

//terrain
#define ToolBar_Button_Terrain_Origin_X                      51.0f
#define ToolBar_Button_Terrain_Origin_Y ToolBar_Button_Normal_Origin_Y
#define ToolBar_Button_Terrain_Width                         30.0f
#define ToolBar_Button_Terrain_Height                        30.0f
#define ToolBar_Button_Terrain_Frame CGRectMake  (                           \
                                            ToolBar_Button_Terrain_Origin_X, \
                                            ToolBar_Button_Terrain_Origin_Y, \
                                            ToolBar_Button_Terrain_Width,    \
                                            ToolBar_Button_Terrain_Height    \
                                                )


//hybrid
#define ToolBar_Button_Hybrid_Origin_X                      82.0f
#define ToolBar_Button_Hybrid_Origin_Y ToolBar_Button_Normal_Origin_Y
#define ToolBar_Button_Hybrid_Width                         30.0f
#define ToolBar_Button_Hybrid_Height                        30.0f
#define ToolBar_Button_Hybrid_Frame CGRectMake  (                           \
                                            ToolBar_Button_Hybrid_Origin_X, \
                                            ToolBar_Button_Hybrid_Origin_Y, \
                                            ToolBar_Button_Hybrid_Width,    \
                                            ToolBar_Button_Hybrid_Height    \
                                                )


@interface StationMapInfoController : BaseController

@property (nonatomic,assign) NSInteger      stationNo;
@property (nonatomic,copy) NSString         *identifier;
@property (nonatomic,copy) NSString         *lineId;

@end
