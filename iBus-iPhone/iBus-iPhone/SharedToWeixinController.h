//
//  SharedToWeixinController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/21/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareController.h"
#import "WXApi.h"

@interface SharedToWeixinController : ShareController
<
WXApiDelegate
>

@property (nonatomic,assign) enum WXScene scene;

@end
