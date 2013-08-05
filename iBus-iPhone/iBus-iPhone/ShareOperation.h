//
//  ShareOperation.h
//  iBus-iPhone
//
//  Created by yanghua on 6/22/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareOperation : NSOperation
<
MTStatusBarOverlayDelegate
>

@property (nonatomic,copy) NSString                 *content;
@property (atomic,assign)  BOOL                     imageSupportSwitch;
@property (atomic,assign)  BOOL                     completed;
@property (atomic,assign)  BOOL                     canceledAfterError;
@property (nonatomic,retain) MTStatusBarOverlay     *overlay;

- (id)initOperationWithContent:(NSString*)content
         andImageSupportSwitch:(BOOL)yesOrNo;

@end
