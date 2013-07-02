//
//  ShareToWeixinOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 6/24/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareToWeixinOperation.h"

@implementation ShareToWeixinOperation

- (id)init{
    if (self=[super init]) {
        _scene=WXSceneSession;
    }
    
    return self;
}

- (id)initOperationWithContent:(NSString *)content
         andImageSupportSwitch:(BOOL)yesOrNo{
    if (self=[super initOperationWithContent:content
                       andImageSupportSwitch:yesOrNo]) {
        _scene=WXSceneSession;
    }
    
    return self;
}

- (void)main{
    
    if (self.imageSupportSwitch) {              //with image
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:[UIImage imageNamed:Resource_OF_AdImage]];
        
        WXImageObject *ext = [WXImageObject object];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AppAd" ofType:@"png"];
        ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = _scene;
        
        [WXApi sendReq:req];
    }else{                                      //no image
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = YES;
        req.text = self.content;
        req.scene = _scene;
        
        [WXApi sendReq:req];
    }
    
    //block current runloop!
    [super main];
}

#pragma mark - weixin delegate -
-(void) onReq:(BaseReq*)req{
    
    
}

-(void) onResp:(BaseResp*)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        NSString *strTitle = [NSString stringWithFormat:@"发送结果"];
        NSString *strMsg = [NSString stringWithFormat:@"发送媒体消息结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        self.completed=YES;
        [NSThread sleepForTimeInterval:5];
    }
    else if([resp isKindOfClass:[SendAuthResp class]]){
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"Auth结果:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}





@end
