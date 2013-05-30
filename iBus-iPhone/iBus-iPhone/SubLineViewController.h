//
//  SubLineViewController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/29/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"
#import "LineListController.h"

#define EDGESTATION_VIEW_HEIGHT 30.0f+1.0f

#define ARROW_WIDTH 70.0f
#define ARROW_HEIGHT 16.0f
#define ARROW_ORIGIN_X (MainWidth * 0.5)- (ARROW_WIDTH/2)
#define ARROW_ORIGIN_Y 7.0f

#define EDGESTATION_LABEL_FONTSIZE 13.0f

#define EDGESTATION_LABEL_WIDTH 110.0f
#define EDGESTATION_LABEL_HEIGHT 30.0f

#define EDGESTATION_LABEL1_ORIGIN_X 3.0f
#define EDGESTATION_LABEL1_ORIGIN_Y 0
#define EDGESTATION_LABEL2_ORIGIN_X MainWidth-EDGESTATION_LABEL_WIDTH-10.0f
#define EDGESTATION_LABEL2_ORIGIN_Y 0

#define EDGESTATION_VIEW_NORMAL_COLOR ColorWithRGBA(233, 233, 233, 1)
#define EDGESTATION_VIEW_HIGHLIGHT_COLOR [UIColor grayColor]

typedef enum {
    TAG_LEFT_TO_RIGHT=1001,
    TAG_RIGHT_TO_LEFT=1002
}TAGS_OF_VIEWS;

@interface SubLineViewController : BaseController

@property (nonatomic,retain) NSDictionary *lineInfo;
@property (nonatomic,retain) LineListController *lineListCtrller;

- (id)initWithLineInfo:(NSDictionary*)lineInfo;

@end
