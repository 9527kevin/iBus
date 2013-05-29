//
//  BaseCell.h
//  iBus-iPhone
//
//  Created by yanghua on 5/28/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

- (void)initSubViews;

- (void)initSubViewsWithModel:(NSDictionary*)modelInfo;

- (void)resizeSubViews;

@end
