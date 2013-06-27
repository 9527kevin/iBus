//
//  LineListCell.h
//  iBus-iPhone
//
//  Created by yanghua on 5/28/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseCell.h"

#define BusPlaceHolder_ImageView_Origin_X           0.0f
#define BusPlaceHolder_ImageView_Origin_Y           10.0f
#define BusPlaceHolder_ImageView_WAndH              40.0f
#define BusPlaceHolder_ImageView_Frame CGRectMake (                         \
                                        BusPlaceHolder_ImageView_Origin_X,  \
                                        BusPlaceHolder_ImageView_Origin_Y,  \
                                        BusPlaceHolder_ImageView_WAndH,     \
                                        BusPlaceHolder_ImageView_WAndH      \
                                        )


#define Arrow_ImageView_Width                       18.0f
#define Arrow_ImageView_Height                      10.0f
#define Arrow_ImageView_Origin_X                    MainWidth - 30.0f
#define Arrow_ImageView_Origin_Y                    27.0f
#define Arrow_ImageView_Frame CGRectMake (                                  \
                                            Arrow_ImageView_Origin_X,       \
                                            Arrow_ImageView_Origin_Y,       \
                                            Arrow_ImageView_Width,          \
                                            Arrow_ImageView_Height          \
                                         )

#define Line_Name_Label_Origin_X                    45.0f
#define Line_Name_Label_Origin_Y                    7.0f
#define Line_Name_Label_Width                       70.0
#define Line_Name_Label_Height                      50.0f
#define Line_Name_Label_Frame CGRectMake (                                  \
                                            Line_Name_Label_Origin_X,       \
                                            Line_Name_Label_Origin_Y,       \
                                            Line_Name_Label_Width,          \
                                            Line_Name_Label_Height          \
                                          )


#define Refresh_Button_Width                        25.0f
#define Refresh_Button_Height                       25.0f
#define Refresh_Button_Origin_X \
Arrow_ImageView_Origin_X - Refresh_Button_Width -13.0f

#define Refresh_Button_Origin_Y                     18.0f


@interface LineListCell : BaseCell

@property (nonatomic,retain) NSDictionary *lineInfo;
@property (strong, nonatomic) UIImageView *arrowImageView;

- (void)changeArrowWithUp:(BOOL)up;

@end
