//
//  AppDelegate.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSOperationQueue *operationQueueCenter;
@property (nonatomic,retain) ZUUIRevealController *zuuiRevealCtrller;

@end
