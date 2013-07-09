//
//  ShareToWeixinOperation.h
//  iBus-iPhone
//
//  Created by yanghua on 6/24/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareOperation.h"
#import "WXApi.h"
#import "SNSApiOAuthConst.h"

@interface ShareToWeixinOperation : ShareOperation

@property (nonatomic,assign) enum WXScene scene;


- (id)initOperationWithContent:(NSString *)content
         andImageSupportSwitch:(BOOL)yesOrNo
                      andScene:(enum WXScene)scene;

@end
