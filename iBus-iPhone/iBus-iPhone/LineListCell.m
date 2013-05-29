//
//  LineListCell.m
//  iBus-iPhone
//
//  Created by yanghua on 5/28/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineListCell.h"

@interface LineListCell ()

@property (nonatomic,retain) UIImageView *busImgView;
@property (nonatomic,retain) UILabel *lineNameLbl;
@property (nonatomic,retain) UILabel *firstTimeLbl;
@property (nonatomic,retain) UILabel *lastTimeLbl;

@end

@implementation LineListCell

- (void)dealloc{
    [_lineInfo release],_lineInfo=nil;
    [_busImgView release],_busImgView=nil;
    [_arrowImageView release],_arrowImageView=nil;
    [_lineNameLbl release],_lineNameLbl=nil;
    [_firstTimeLbl release],_firstTimeLbl=nil;
    [_lastTimeLbl release],_lastTimeLbl=nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        _busImgView=[[UIImageView alloc] initWithFrame:CGRectMake(BUSPLACEHOLDER_IMAGEVIEW_ORIGIN_X, BUSPLACEHOLDER_IMAGEVIEW_ORIGIN_Y, BUSPLACEHOLDER_IMAGEVIEW_WAndH, BUSPLACEHOLDER_IMAGEVIEW_WAndH)];
        self.busImgView.image=[UIImage imageNamed:@"busPlaceHolder.png"];
        [self addSubview:self.busImgView];
        
        _arrowImageView=[[UIImageView alloc] initWithFrame:CGRectMake(ARROW_IMAGEVIEW_ORIGIN_X, ARROW_IMAGEVIEW_ORIGIN_Y, ARROW_IMAGEVIEW_WIDTH, ARROW_IMAGEVIEW_HEIGHT)];
        [self addSubview:self.arrowImageView];
        
        
    }
    
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.lineNameLbl=nil;
    self.firstTimeLbl=nil;
    self.lastTimeLbl=nil;
}

- (void)initSubViewsWithModel:(NSDictionary*)modelInfo{
    _lineInfo=[modelInfo retain];
    
    
    _lineNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(LINE_NAME_LABEL_ORIGIN_X, LINE_NAME_LABEL_ORIGIN_Y, LINE_NAME_LABEL_WIDTH, LINE_NAME_LABEL_HEIGHT)];
    self.lineNameLbl.text=self.lineInfo[@"lineName"];
    self.lineNameLbl.font=[UIFont systemFontOfSize:18.0f];
    [self addSubview:self.lineNameLbl];
    
    _firstTimeLbl=[[UILabel alloc] initWithFrame:CGRectMake(TIME_LABEL_ORIGIN_X, FIRST_TIME_LABEL_ORIGIN_Y, TIME_LABEL_WIDTH, TIME_LABEL_HEIGHT)];
    self.firstTimeLbl.text=[NSString stringWithFormat:@"首班时间:%@",self.lineInfo[@"firstTime"]];
    
    self.firstTimeLbl.font=[UIFont systemFontOfSize:TIME_LABEL_FONTSIZE];
    [self addSubview:self.firstTimeLbl];
    
    _lastTimeLbl=[[UILabel alloc] initWithFrame:CGRectMake(TIME_LABEL_ORIGIN_X, LAST_TIME_LABEL_ORIGIN_Y, TIME_LABEL_WIDTH, TIME_LABEL_HEIGHT)];
    self.lastTimeLbl.text=[NSString stringWithFormat:@"末班时间:%@",self.lineInfo[@"lastTime"]];
    self.lastTimeLbl.font=[UIFont systemFontOfSize:TIME_LABEL_FONTSIZE];
    [self addSubview:self.lastTimeLbl];
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

- (void)changeArrowWithUp:(BOOL)up
{
    if (up) {
        self.arrowImageView.image = [UIImage imageNamed:@"UpAccessory.png"];
    }else{
        self.arrowImageView.image = [UIImage imageNamed:@"DownAccessory.png"];
    }
}

@end
