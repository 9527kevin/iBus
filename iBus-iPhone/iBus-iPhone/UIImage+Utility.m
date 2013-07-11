//
//  UIImage+Utility.m
//  iBus-iPhone
//
//  Created by yanghua on 7/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

+ (UIImage*)mergeImage:(UIImage*)incoming
               toImage:(UIImage*)original
                atZoom:(CGRect)zoom{
    //support for retina
    UIGraphicsBeginImageContextWithOptions(original.size,NO,0.0f);
        
    [original drawInRect:CGRectMake(0, 0, original.size.width, original.size.height)];
    [incoming drawInRect:zoom];
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

+ (UIImage *)imageWithPureColor:(UIColor *)tintColor
                        andSize:(CGSize)imgSize{
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0.0f);
    
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, imgSize.width, imgSize.height);
    UIRectFill(bounds);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return tintedImage;
}

@end
