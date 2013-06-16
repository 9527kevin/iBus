//
//  StationListCell.h
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseCell.h"

#define Station_ImageView_Origin_X 5.0f
#define Station_ImageView_Origin_Y 5.0f

#define Station_ImageView_Width 40.0f
#define Station_ImageView_Height 40.0f

#define Station_Name_Label_Origin_X 50.0f
#define Station_Name_Label_Origin_Y 5.0f
#define Station_Name_Label_Width 150.0f
#define Station_Name_Label_Height 40.0f

#define Map_Button_Width 20.0f
#define Map_Button_Height 32.0f
#define Map_Button_Origin_X MainWidth - Map_Button_Width - 10.0f
#define Map_Button_Origin_Y 9.0f

#define Favorite_Button_Width 24.0f
#define Favorite_Button_Height 24.0f
#define Favorite_Button_Origin_X Map_Button_Origin_X - Favorite_Button_Width -10.0f
#define Favorite_Button_Origin_Y 12.0f


@interface StationListCell : BaseCell

@property (nonatomic,retain) NSMutableDictionary *stationInfo;

@end
