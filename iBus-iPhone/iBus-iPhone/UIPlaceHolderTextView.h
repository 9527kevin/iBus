//	
//  UIPlaceHolderTextView.h
//  RenRenTest
//
//  Created by svp on 12.06.12.
//  Copyright 2012 yanghua_kobe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIPlaceHolderTextView : UITextView 

@property (nonatomic,retain) UILabel    *placeholderLabel;
@property (nonatomic,copy) NSString     *placeholder;
@property (nonatomic,retain) UIColor    *placeholderColor;

-(void)textChanged:(NSNotification *)nofification;

@end
