//
//  MapHelper.h
//  iBus-iPhone
//
//  Created by yanghua on 6/1/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    double lat;
    double log;
}MarsGeodetic;

@interface MapHelper : NSObject

+ (MarsGeodetic)transformWithWGLat:(double)wgLat andWGLon:(double)wgLon;

@end
