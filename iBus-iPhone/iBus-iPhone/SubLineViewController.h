//
//  SubLineViewController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/29/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"
#import "LineListController.h"

#define EDGESTATION_BUTTON_HEIGHT 30.0f


@interface SubLineViewController : BaseController

@property (nonatomic,retain) NSDictionary *lineInfo;
@property (nonatomic,retain) LineListController *lineListCtrller;

- (id)initWithLineInfo:(NSDictionary*)lineInfo;

@end
