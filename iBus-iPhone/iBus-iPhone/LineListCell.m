//
//  LineListCell.m
//  iBus-iPhone
//
//  Created by yanghua on 5/28/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineListCell.h"
#import "QuartzCore/CAAnimation.h"

@interface LineListCell ()

@property (nonatomic,retain) UIImageView *busImgView;
@property (nonatomic,retain) UILabel *lineNameLbl;
@property (nonatomic,retain) UIButton *refreshBtn;

@end

@implementation LineListCell

- (void)dealloc{
    [_lineInfo release],_lineInfo=nil;
    [_busImgView release],_busImgView=nil;
    [_arrowImageView release],_arrowImageView=nil;
    [_lineNameLbl release],_lineNameLbl=nil;
    
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
}

- (void)initSubViewsWithModel:(NSDictionary*)modelInfo{
    _lineInfo=[modelInfo retain];
    
    
    _lineNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(LINE_NAME_LABEL_ORIGIN_X, LINE_NAME_LABEL_ORIGIN_Y, LINE_NAME_LABEL_WIDTH, LINE_NAME_LABEL_HEIGHT)];
    self.lineNameLbl.text=self.lineInfo[@"lineName"];
    self.lineNameLbl.font=[UIFont systemFontOfSize:18.0f];
    [self addSubview:self.lineNameLbl];
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

- (void) runSpinAnimationWithDuration:(CGFloat) duration;
{
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    
    [self.refreshBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
