//
//  StationListCell.m
//  iBus-iPhone
//
//  Created by yanghua on 5/31/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationListCell.h"
#import "StationDao.h"

@interface StationListCell ()

@property (nonatomic,retain) UIImageView        *stationImgView;
@property (nonatomic,retain) UILabel            *stationNameLbl;
@property (nonatomic,retain) UIButton           *mapBtn;
@property (nonatomic,retain) UIButton           *favoriteBtn;

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
        _stationImgView=[[UIImageView alloc] initWithFrame:Station_ImageView_Frame];
        self.stationImgView.image=[UIImage imageNamed:@"busStation.png"];
        [self addSubview:self.stationImgView];
        
        _mapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.mapBtn.frame=Map_Button_Frame;
        [self.mapBtn setBackgroundImage:[UIImage imageNamed:@"mapBtn.png"]
                               forState:UIControlStateNormal];
        [self addSubview:self.mapBtn];
        
        _favoriteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.favoriteBtn.frame=Favorite_Button_Frame;
        [self addSubview:self.favoriteBtn];
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.stationNameLbl.text=nil;
}

- (void)initSubViewsWithModel:(NSMutableDictionary*)modelInfo{
    _stationInfo=modelInfo;
    
    _stationNameLbl=[[UILabel alloc] initWithFrame:Station_Name_Label_Frame];
    _stationNameLbl.backgroundColor=[UIColor clearColor];
    _stationNameLbl.text=modelInfo[@"stationName"];
    [self addSubview:self.stationNameLbl];
    
    Boolean isFavorities=[self.stationInfo[@"identifier"] isEqualToString:@"1"] ?
                         [self.stationInfo[@"identifier_1_favorite"] boolValue] :
                         [self.stationInfo[@"identifier_2_favorite"] boolValue];
    
    if (isFavorities) {
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favoriteBtn_highlight.png"]
                                    forState:UIControlStateNormal];
    }else{
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favoriteBtn_normal.png"]
                                    forState:UIControlStateNormal];
    }
    
    //register events for favorite button
    [self.favoriteBtn addTarget:self
                         action:@selector(handleFavorite:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapBtn addTarget:self
                    action:@selector(handleMapButton:)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)resizeSubViews{
    
}

- (void)handleFavorite:(UIButton*)sender{
    Boolean isFavorities=[StationDao isFavoriteWithLineId:self.stationInfo[@"lineId"]
                                            andIdentifier:self.stationInfo[@"identifier"]
                                               andOrderNo:self.stationInfo[@"orderNo"]];
    
    if (isFavorities) {
        [StationDao unfavoriteWithLineId:self.stationInfo[@"lineId"]
                           andIdentifier:self.stationInfo[@"identifier"]
                              andOrderNo:self.stationInfo[@"orderNo"]];
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favoriteBtn_normal.png"]
                                    forState:UIControlStateNormal];
    }else{
        [StationDao favoriteWithLineId:self.stationInfo[@"lineId"]
                         andIdentifier:self.stationInfo[@"identifier"]
                            andOrderNo:self.stationInfo[@"orderNo"]];
        [self.favoriteBtn setBackgroundImage:[UIImage imageNamed:@"favoriteBtn_highlight.png"]
                                    forState:UIControlStateNormal];

    }
    
    [Default_Notification_Center postNotificationName:Notification_For_Favorited object:nil];
}

- (void)handleMapButton:(id)sender{
    if ([self.delegate respondsToSelector:@selector(showMapViewController:)]) {
        [self.delegate showMapViewController:self.stationInfo];
    }
}



@end
