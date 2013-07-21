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
         andImageSupportSwitch:(BOOL)yesOrNo
                      andScene:(enum WXScene)scene{
    if (self=[super initOperationWithContent:content
                       andImageSupportSwitch:yesOrNo]) {
        _scene=scene;
    }
    
    return self;
}

- (void)main{
    
    if (self.imageSupportSwitch) {              //with image
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:[UIImage imageNamed:@"IconForAbout.png"]];
        [message setTitle:@"江宁掌上公交"];
        [message setDescription:@"江宁掌上公交"];
        
        WXImageObject *ext = [WXImageObject object];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AppAd" ofType:@"jpeg"];
        ext.imageData = [NSData dataWithContentsOfFile:filePath] ;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = NO;
        req.message = message;
        req.scene = self.scene;
        
        [WXApi sendReq:req];
    }else{                                      //no image
        SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
        req.bText = YES;
        req.text = self.content;
        req.scene = self.scene;
        
        [WXApi sendReq:req];
    }
    
}

@end
