//
//  AboutDeveloperController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseController.h"
#import "NIAttributedLabel.h"
#import <MessageUI/MessageUI.h>

@protocol NIAttributedLabelDelegate;

@interface AboutDeveloperController : BaseController
<
NIAttributedLabelDelegate,
MFMailComposeViewControllerDelegate
>


@end
