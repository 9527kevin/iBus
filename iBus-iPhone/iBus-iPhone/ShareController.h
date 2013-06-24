//
//  ShareController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "PublishBaseController.h"
#import "SNSApiOAuthConst.h"



@interface ShareController : PublishBaseController
<
PublishBaseControllerDelegate
>

- (BOOL)isAuthorized;

- (void)login;

- (void)logout;

- (void)share;

@end
