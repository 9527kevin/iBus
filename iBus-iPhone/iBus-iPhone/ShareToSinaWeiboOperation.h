//
//  ShareToSinaWeiboOperation.h
//  iBus-iPhone
//
//  Created by yanghua on 6/24/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareOperation.h"
#import "SinaWeibo.h"

@protocol SinaWeiboRequestDelegate;

@interface ShareToSinaWeiboOperation : ShareOperation
<
SinaWeiboRequestDelegate,
SinaWeiboDelegate
>



@end
