//
//  ShareController.h
//  iBus-iPhone
//
//  Created by yanghua on 6/20/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "PublishBaseController.h"


@interface ShareController : PublishBaseController
<
PublishBaseControllerDelegate
>

@property (nonatomic,retain) NSMutableArray *followedList;

- (BOOL)isAuthorized;

- (void)login;

- (void)logout;

- (void)share;



@end
