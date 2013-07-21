//
//  UIImage+Utility.h
//  iBus-iPhone
//
//  Created by yanghua on 7/10/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)


/**
 *	@brief	merge two images at special zoom
 *
 *	@param 	incoming 	to be merged image
 *	@param 	original 	original image
 *	@param 	zoom 	rect
 *
 *	@return	the merged image
 */
+ (UIImage*)mergeImage:(UIImage*)incoming
               toImage:(UIImage*)original
                atZoom:(CGRect)zoom;


/**
 *	@brief	generate a image with a pure color
 *
 *	@param 	tintColor 	the color
 *	@param 	imgSize 	the image's size
 *
 *	@return	generated image
 */
+ (UIImage *)imageWithPureColor:(UIColor *)tintColor
                        andSize:(CGSize)imgSize;




@end
