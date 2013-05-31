//
//  StationListCell.m
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationListCell.h"

@interface StationListCell ()

@property (nonatomic,retain) UIImageView *stationImgView;
@property (nonatomic,retain) UILabel *stationNameLbl;

@end

@implementation StationListCell

- (void)dealloc{
    [_stationImgView release],_stationImgView=nil;
    [_stationNameLbl release],_stationNameLbl=nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    
}

- (void)initSubViewsWithModel:(NSDictionary*)modelInfo{
    _stationImgView=[[UIImageView alloc] initWithFrame:CGRectMake(Station_ImageView_Origin_X, Station_ImageView_Origin_Y, Station_ImageView_Width, Station_ImageView_Height)];
    self.stationImgView.image=[UIImage imageNamed:@"busStation.png"];
    
    
    
    [self addSubview:self.stationImgView];
}

- (void)resizeSubViews{
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
