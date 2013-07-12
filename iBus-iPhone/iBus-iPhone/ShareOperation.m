//
//  ShareOperation.m
//  iBus-iPhone
//
//  Created by yanghua on 6/22/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "ShareOperation.h"

@implementation ShareOperation

- (void)dealloc{
    [_content release],_content=nil;
    
    [super dealloc];
}

- (id)init{
    if (self=[super init]) {
        _content=@"";
        _imageSupportSwitch=NO;
        
        _completed=NO;
        _canceledAfterError=NO;
        [self initMTStatusBarOverlay];
    }
    
    return self;
}

- (id)initOperationWithContent:(NSString*)content
         andImageSupportSwitch:(BOOL)yesOrNo{
    
    if (self=[super init]) {
        _content=[content retain];
        _imageSupportSwitch=yesOrNo;
        
        _completed=NO;
        _canceledAfterError=NO;
        [self initMTStatusBarOverlay];
    }
    
    return self;
}

-(void)initMTStatusBarOverlay{
    _overlay = [MTStatusBarOverlay sharedInstance];
    _overlay.animation = MTStatusBarOverlayAnimationFallDown;
    _overlay.detailViewMode = MTDetailViewModeHistory;
    _overlay.delegate=self;
}

- (void)main{
    //操作既没有完成也没有因为发生错误而取消，则hold住当前run loop
    //防止返回主线程使得代理方法无法执行
    while (!(self.completed||self.canceledAfterError)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
    
}



@end
