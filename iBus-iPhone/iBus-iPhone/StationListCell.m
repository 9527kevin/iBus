//
//  StationListCell.m
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationListCell.h"

@interface StationListCell ()

@property (nonatomic,retain) UIImageView        *stationImgView;
@property (nonatomic,retain) UILabel            *stationNameLbl;
@property (nonatomic,retain) UIButton           *mapBtn;
@property (nonatomic,retain) UILabel            *countdownTimeLbl;  //倒计时显示

@end

@implementation StationListCell

- (void)dealloc{
    [_stationImgView release],_stationImgView=nil;
    [_stationNameLbl release],_stationNameLbl=nil;
    [_stationInfo release],_stationInfo=nil;
    [_countdownTimeLbl release],_countdownTimeLbl=nil;
    
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
    self.stationNameLbl.text=nil;
    self.countdownTimeLbl.text=nil;
}

- (void)initSubViewsWithModel:(NSMutableDictionary*)modelInfo{
    _stationInfo=[modelInfo retain];
    
    _stationNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(Station_Name_Label_Origin_X, Station_Name_Label_Origin_Y, Station_Name_Label_Width, Station_Name_Label_Height)];
    _stationNameLbl.backgroundColor=[UIColor clearColor];
    _stationNameLbl.text=modelInfo[@"stationName"];
    [self addSubview:self.stationNameLbl];
    
    
    if (modelInfo[@"countDownTime"]) {
        NSLog(@"%@",self.stationInfo[@"countDownTime"]);
        
        _countdownTimeLbl=[[UILabel alloc] initWithFrame:CGRectMake(CountDown_Label_Origin_X, CountDown_Label_Origin_Y, CountDown_Label_Width, CountDown_Label_Height)];
        _countdownTimeLbl.backgroundColor=[UIColor redColor];
        _countdownTimeLbl.backgroundColor=[UIColor clearColor];
        _countdownTimeLbl.textAlignment=NSTextAlignmentRight;
        _countdownTimeLbl.text=[NSString stringWithFormat:@"%@分钟",self.stationInfo[@"countDownTime"]];
        [_countdownTimeLbl setFont:[UIFont systemFontOfSize:CountDown_Label_FontSize]];
        [self addSubview:self.countdownTimeLbl];
    }else{
        NSLog(@"Nil!!!!!");
    }
    
    
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
