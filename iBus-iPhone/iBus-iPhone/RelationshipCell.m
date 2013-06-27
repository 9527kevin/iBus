//
//  FollowedCell.m
//  weiboDemo
//
//  Created by yanghua on 3/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "RelationshipCell.h"

@interface RelationshipCell ()

@property (nonatomic,retain) UILabel     *nickNameLbl;

@end

@implementation RelationshipCell

- (void)dealloc{
    [_nickName release],_nickName=nil;
    [_nickNameLbl release],_nickNameLbl=nil;
    [_headImgView release],_headImgView=nil;
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //head image
        _headImgView=[[UIImageView alloc] init];
        _headImgView.frame=Head_ImgView_Frame;
        [self addSubview:_headImgView];
        
        //nick name
        _nickNameLbl=[[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLbl.font=[UIFont systemFontOfSize:NickName_TxtView_FontSize];
        _nickNameLbl.frame=NickName_TxtView_Frame;
        [self addSubview:_nickNameLbl];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self resizeSubViews];
}

#pragma mark - override setter -
- (void)setNickName:(NSString *)nickName{
    if (![_nickName isEqualToString:nickName]) {
        [_nickName release];
        _nickName=[nickName retain];
    }
    
    if ([_nickName length]>=NickName_Length) {
        _nickName=[NSString stringWithFormat:@"%@...",_nickName];
    }
    
    self.nickNameLbl.text=self.nickName;
}

#pragma mark - override methods -
- (void)resizeSubViews{
    [super resizeSubViews];
}

@end
