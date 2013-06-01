//
//  BusDynamicStateOfLineController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"


@interface LineDynamicStateController : BaseController

@property (nonatomic,assign) NSInteger stationNo;
@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *lineId;

@end
