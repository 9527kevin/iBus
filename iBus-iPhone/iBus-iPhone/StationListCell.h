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

@interface StationListCell : BaseCell

@property (nonatomic,retain) NSDictionary *stationInfo;

@end
