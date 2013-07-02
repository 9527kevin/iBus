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
<
WXApiDelegate
>
{
    enum WXScene _scene;
}

@end
