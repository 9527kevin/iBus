//
//  BaseController.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

- (void)initNavigationController;

- (void)initNavLeftBackButton;

- (void)initNavRightBarButton;

- (void)handleBack:(id)sender;

- (void)handleRightBarButton:(id)sender;

- (void)revealToggle:(id)sender;

@end
