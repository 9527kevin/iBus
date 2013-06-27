//
//  StationListControllerViewController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ELTableViewController.h"
#import "StationListCell.h"

#define Notification_For_LoadCountDownTimeCallbackCompleted                 \       @"Notification_For_LoadCountDownTimeCallbackCompleted"

@interface StationListController : ELTableViewController
<
StationListCellDelegate
>

@property (nonatomic,copy) NSString *lineId;
@property (nonatomic,copy) NSString *lineName;
@property (nonatomic,copy) NSString *identifier;

@end
