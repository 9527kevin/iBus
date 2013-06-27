//
//  BaseCell.m
//  iBus-iPhone
//
//  Created by yanghua on 5/28/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - to be override -
- (void)initSubViews{
    
}

- (void)initSubViewsWithModel:(NSDictionary*)modelInfo{
    
}

- (void)resizeSubViews{
    
}

@end
