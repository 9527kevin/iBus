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
@property (nonatomic,retain) UIButton *mapBtn;

@end

@implementation StationListCell

- (void)dealloc{
    [_stationImgView release],_stationImgView=nil;
    [_stationNameLbl release],_stationNameLbl=nil;
    [_stationInfo release],_stationInfo=nil;
    
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _stationImgView=[[UIImageView alloc] initWithFrame:CGRectMake(Station_ImageView_Origin_X, Station_ImageView_Origin_Y, Station_ImageView_Width, Station_ImageView_Height)];
        self.stationImgView.image=[UIImage imageNamed:@"busStation.png"];
        [self addSubview:self.stationImgView];
        
        _mapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.mapBtn.frame=CGRectMake(Map_Button_Origin_X, Map_Button_Origin_Y, Map_Button_Width, Map_Button_Height);
        [self.mapBtn setBackgroundImage:[UIImage imageNamed:@"mapBtn.png"] forState:UIControlStateNormal];
        [self addSubview:self.mapBtn];
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    _stationNameLbl.text=nil;
}

- (void)initSubViewsWithModel:(NSDictionary*)modelInfo{
    _stationInfo=[modelInfo retain];
    
    _stationNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(Station_Name_Label_Origin_X, Station_Name_Label_Origin_Y, Station_Name_Label_Width, Station_Name_Label_Height)];
    _stationNameLbl.text=modelInfo[@"stationName"];
    [self addSubview:self.stationNameLbl];
    
    
    
    
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
