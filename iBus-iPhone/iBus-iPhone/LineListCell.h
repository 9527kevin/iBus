//
//  LineListCell.h
//  iBus-iPhone
//
//  Created by yanghua on 5/28/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseCell.h"

#define BUSPLACEHOLDER_IMAGEVIEW_ORIGIN_X 0.0f
#define BUSPLACEHOLDER_IMAGEVIEW_ORIGIN_Y 10.0f
#define BUSPLACEHOLDER_IMAGEVIEW_WAndH 40.0f


#define ARROW_IMAGEVIEW_WIDTH 18.0f
#define ARROW_IMAGEVIEW_HEIGHT 10.0f
#define ARROW_IMAGEVIEW_ORIGIN_X MainWidth-30.0f
#define ARROW_IMAGEVIEW_ORIGIN_Y 27.0f

#define LINE_NAME_LABEL_ORIGIN_X 45.0f
#define LINE_NAME_LABEL_ORIGIN_Y 7.0f
#define LINE_NAME_LABEL_WIDTH 70.0
#define LINE_NAME_LABEL_HEIGHT 50.0f


#define Refresh_Button_Width 25.0f
#define Refresh_Button_Height 25.0f
#define Refresh_Button_Origin_X ARROW_IMAGEVIEW_ORIGIN_X - Refresh_Button_Width -13.0f
#define Refresh_Button_Origin_Y 18.0f


@interface LineListCell : BaseCell

@property (nonatomic,retain) NSDictionary *lineInfo;
@property (strong, nonatomic) UIImageView *arrowImageView;

- (void)changeArrowWithUp:(BOOL)up;

@end
