//
//  SubLineViewController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/29/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"
#import "LineListController.h"

#define EdgeStation_View_Height 40.0f+1.0f

#define Root_View_Frame CGRectMake  (                                       \
                                        0.0f,                               \
                                        0.0f,                               \
                                        MainWidth,                          \
                                        (EdgeStation_View_Height) * 2       \
                                    )

//go view
#define Go_View_Frame CGRectMake    (                                       \
                                        0.0f,                               \
                                        0.0f,                               \
                                        MainWidth,                          \
                                        EdgeStation_View_Height             \
                                    )

//back view
#define Back_View_Frame CGRectMake  (                                       \
                                        0.0f,                               \
                                        (EdgeStation_View_Height) + 1.0f,   \
                                        MainWidth,                          \
                                        EdgeStation_View_Height             \
                                    )
                                        

#define Arrow_Width 70.0f
#define Arrow_Height 16.0f
#define Arrow_Origin_X (MainWidth * 0.5)- (Arrow_Width/2)
#define Arrow_Origin_Y 11.0f
#define Arrow_Frame CGRectMake  (                                           \
                                    Arrow_Origin_X,                         \
                                    Arrow_Origin_Y,                         \
                                    Arrow_Width,                            \
                                    Arrow_Height                            \
                                )

#define EdgeStation_Label_FontSize 13.0f
#define EdgeStation_Label_Width 110.0f
#define EdgeStation_Label_Height 30.0f

#define EdgeStation_Label1_Origin_X 3.0f
#define EdgeStation_Label1_Origin_Y 7.0f
#define EdgeStation_Label1_Frame CGRectMake (                               \
                                                EdgeStation_Label1_Origin_X,\
                                                EdgeStation_Label1_Origin_Y,\
                                                EdgeStation_Label_Width,    \
                                                EdgeStation_Label_Height    \
                                            )

#define EdgeStation_Label2_Origin_X MainWidth - EdgeStation_Label_Width - 10.0f
#define EdgeStation_Label2_Origin_Y 7.0f
#define EdgeStation_Label2_Frame CGRectMake (                               \
                                                EdgeStation_Label2_Origin_X,\
                                                EdgeStation_Label2_Origin_Y,\
                                                EdgeStation_Label_Width,    \
                                                EdgeStation_Label_Height    \
                                            )


#define EdgeStation_View_Normal_Color ColorWithRGBA(233, 233, 233, 1)
#define EdgeStation_View_Highlight_Color [UIColor grayColor]


typedef enum {
    TAG_LEFT_TO_RIGHT=1001,
    TAG_RIGHT_TO_LEFT=1002
}TAGS_OF_VIEWS;

@interface SubLineViewController : BaseController

@property (nonatomic,retain) NSDictionary *lineInfo;
@property (nonatomic,retain) LineListController *lineListCtrller;

- (id)initWithLineInfo:(NSDictionary*)lineInfo;

@end
