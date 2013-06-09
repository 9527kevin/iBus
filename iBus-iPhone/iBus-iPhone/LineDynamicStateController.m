//
//  LineDynamicStateController.m
//  iBus-iPhone
//
//  Created by yanghua on 6/7/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "LineDynamicStateController.h"
#import "StationDao.h"

@interface LineDynamicStateController ()

@property (nonatomic,retain) UIView *containerView;
@property (nonatomic,retain) UILabel *bottomNextTimeLbl;
@property (nonatomic,retain) UILabel *bottomTipLbl;

@property (nonatomic,retain) NSMutableArray *dataSource;

//hack cotainer view array
@property (nonatomic,retain) NSMutableArray *GCContainerViewArray;


@end

@implementation LineDynamicStateController

- (void)dealloc{
    [_identifier release],_identifier=nil;
    [_lineId release],_lineId=nil;
    [_containerView release],_containerView=nil;
    [_bottomTipLbl release],_bottomTipLbl=nil;
    [_bottomNextTimeLbl release],_bottomNextTimeLbl=nil;
    [_dataSource release],_dataSource=nil;
    [_stationName release],_stationName=nil;
    [_GCContainerViewArray release],_GCContainerViewArray=nil;
    
    [super dealloc];
}

- (void)loadView{
    self.view=[[[UIView alloc] initWithFrame:Default_Frame_WithoutStatusBar] autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    //top tip
    UILabel *topTipLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Toptip_StationList_Label_Origin_X, Toptip_StationList_Label_Origin_Y, Toptip_Label_Width, Toptip_Label_Height)] autorelease];
    topTipLbl.font=[UIFont systemFontOfSize:Toptip_Label_FontSize];
    topTipLbl.text=@"公交位置";
    [self.view addSubview:topTipLbl];
    
    UILabel *countDownTimeLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Toptip_CountDownTime_Label_Origin_X, Toptip_CountDownTime_Label_Origin_Y, Toptip_CountDownTime_Label_Width, Toptip_Label_Height)] autorelease];
    countDownTimeLbl.font=[UIFont systemFontOfSize:Toptip_Label_FontSize];
    countDownTimeLbl.text=@"倒计时";
    [self.view addSubview:countDownTimeLbl];
    
    UILabel *distanceLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Toptip_Distance_Label_Origin_X, Toptip_Distance_Label_Origin_Y, Toptip_Distance_Label_Width, Toptip_Label_Height)] autorelease];
    distanceLbl.font=[UIFont systemFontOfSize:Toptip_Label_FontSize];
    distanceLbl.text=@"剩余距离";
    [self.view addSubview:distanceLbl];
    
    //dynamic state container view
    [self initDynamicStateContainerView];
    
    //bottom tip
    _bottomTipLbl=[[UILabel alloc] initWithFrame:CGRectMake(BottomTip_Label_Origin_X, BottomTip_Label_Origin_Y, BottomTip_Label_Width, BottomTip_Label_Height)];
    self.bottomTipLbl.font=[UIFont systemFontOfSize:BottomTip_Label_FontSize];
    self.bottomTipLbl.text=@"下一班预计发车时间:";
    [self.view addSubview:self.bottomTipLbl];
    
    //bottom next-bus coming time
    _bottomNextTimeLbl=[[UILabel alloc] initWithFrame:CGRectMake(BottomNextTime_Label_Origin_X, BottomNextTime_Label_Origin_Y, BottomNextTime_Label_Width, BottomNextTime_Label_Height)];
    self.bottomNextTimeLbl.font=[UIFont systemFontOfSize:BottomNextTime_Label_FontSize];
    self.bottomNextTimeLbl.textColor=[UIColor redColor];
    [self.view addSubview:self.bottomNextTimeLbl];
    
    //hack container view
    _GCContainerViewArray=[[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=self.stationName;
	
    self.dataSource=[StationDao getDynamicStationList:self.lineId
                                         andStationId:[NSNumber numberWithInt:self.stationNo]
                                        andIdentifier:self.identifier];
    [self layoutDynamicStationSubviews];
    
    [self sendRequest4GetDynamicStateInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods -
- (void)initDynamicStateContainerView{
    _containerView=[[UIView alloc] initWithFrame:CGRectMake(Dynamic_State_ContainerView_Origin_X, Dynamic_State_ContainerView_Origin_Y, Dynamic_State_ContainerView_Width, Dynamic_State_ContainerView_Height)];
    self.containerView.backgroundColor=ColorWithRGBA(245, 245, 245, 1);
    [self.view addSubview:self.containerView];
    
    [self initDynamicStationLabels];
    [self initStationDirectionArrow];
}

- (void)initDynamicStationLabels{
    for (int i=0; i<Dynamic_Station_List_Count; i++) {
        //station name label
        UILabel *stationLbl=[[[UILabel alloc] initWithFrame:CGRectMake(Station_Label_Origin_X, Station_Label_Margin+(Station_Label_Margin+Station_Label_Height)*i, Station_Label_Width, Station_Label_Height)] autorelease];
        stationLbl.tag=Station_Label_StartIndex + i;
        stationLbl.textAlignment=NSTextAlignmentRight;
        stationLbl.backgroundColor=[UIColor clearColor];
        stationLbl.textColor=[UIColor blueColor];
        stationLbl.font=[UIFont systemFontOfSize:Station_Label_FontSize];
        
        [self.containerView addSubview:stationLbl];
    }
}

- (void)initStationDirectionArrow{
    UIImageView *stationDirectionArrowImgView=[[[UIImageView alloc] initWithFrame:CGRectMake(Arrow_ImageView_Origin_X, Arrow_ImageView_Origin_Y, Arrow_ImageView_Width, Arrow_ImageView_Height)] autorelease];
    stationDirectionArrowImgView.image=[UIImage imageNamed:@"arrowStation.png"];
    [self.containerView addSubview:stationDirectionArrowImgView];
}


- (void)layoutDynamicStationSubviews{
    if (self.dataSource.count==0) {
        return;
    }
    
    for (int i=0; i<self.dataSource.count; i++) {        
        UILabel *stationLbl=(UILabel *)[self.containerView viewWithTag:Station_Label_StartIndex+i];
        stationLbl.text=self.dataSource[i][@"stationName"];
    }
}

- (void)setStationMarker:(int)directionStationNo
             andDistance:(NSString*)distance
        andCountDownTime:(NSString*)countDownTime{
    
    if (directionStationNo>8) {
        return;
    }
    
    //bus marker image view
    CGRect currentStationMarkerFrame=CGRectMake(StationEntryMark_ImageView_Origin_X, StationEntryMark_ImageView_Margin+(StationEntryMark_ImageView_Margin+Station_Label_Height)*directionStationNo, StationEntryMark_ImageView_Width, StationEntryMark_ImageView_Height);
    
    UIImageView *stationMarkerImgView=[[UIImageView alloc] initWithFrame:currentStationMarkerFrame];
    stationMarkerImgView.image=[UIImage imageNamed:@"stationBusMarker.png"];
    [self.containerView addSubview:stationMarkerImgView];
    
    [self.GCContainerViewArray addObject:stationMarkerImgView];
    
    //count down time
    CGRect currentCountDownTimeFrame=CGRectMake(currentStationMarkerFrame.origin.x + currentStationMarkerFrame.size.width+5.0f, currentStationMarkerFrame.origin.y, Toptip_CountDownTime_Label_Width, Toptip_Distance_Label_Width);
    UILabel *countDownTimeLbl=[[[UILabel alloc] initWithFrame:currentCountDownTimeFrame] autorelease];
    countDownTimeLbl.backgroundColor=[UIColor clearColor];
    countDownTimeLbl.text=countDownTime;
    [self.containerView addSubview:countDownTimeLbl];
    
    [self.GCContainerViewArray addObject:countDownTimeLbl];         //add to gc
    
    //distance
    CGRect currentDistanceFrame=CGRectMake(currentCountDownTimeFrame.origin.x+currentCountDownTimeFrame.size.width, currentStationMarkerFrame.origin.y, Toptip_CountDownTime_Label_Width, Toptip_Distance_Label_Width);
    UILabel *distanceLbl=[[[UILabel alloc] initWithFrame:currentDistanceFrame] autorelease];
    [distanceLbl setBackgroundColor:[UIColor clearColor]];
    distanceLbl.text=distance;
    [self.containerView addSubview:distanceLbl];
    
    [self.GCContainerViewArray addObject:distanceLbl];              //add to gc
}

- (void)sendRequest4GetDynamicStateInfo{
    NSURL *requestUrl=[NSURL URLWithString:[NSString stringWithFormat:Url_DestinationDistance,self.lineId,self.identifier,self.stationNo]];
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:requestUrl];

    [request setCompletionBlock:^{
        NSData *responseData=[request responseData];
        NSDictionary *responseDic=[NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingAllowFragments
                                                                    error:nil];
        //exist bus info
        if ([responseDic[@"success"] boolValue]==true && responseDic[@"rows"] && [responseDic[@"rows"] count]>0) {
            self.dataSource=[StationDao getDynamicStationList:self.lineId
                                                  andStationId:[NSNumber numberWithInt:self.stationNo]
                                                 andIdentifier:self.identifier];
            [self clear];
            
            //rows
            NSArray *busArray=responseDic[@"rows"];
            for (NSDictionary *busInfo in busArray) {
                NSString *disStr=busInfo[@"dis"];
                if (disStr && disStr.length>0) {
                    
                    //count down time
                    NSString *countDownTimeStr=nil;
                    NSString *tmpDisForCountDownTime=[disStr copy];
                    NSRange startRange=[tmpDisForCountDownTime rangeOfString:@"约"
                                                                     options:NSBackwardsSearch];
                    if ([tmpDisForCountDownTime length]>=startRange.location+1) {
                        tmpDisForCountDownTime=[tmpDisForCountDownTime substringFromIndex:startRange.location+1];
                        NSRange endRange=[tmpDisForCountDownTime rangeOfString:@"分钟"];
                        if ([disStr length]>=endRange.location) {
                            countDownTimeStr=[tmpDisForCountDownTime substringToIndex:endRange.location];
                        }
                    }
                    
                    
                    //distance
                    NSString *distanceStr=nil;
                    NSString *tmpDisFordistance=[disStr copy];
                    startRange=[tmpDisFordistance rangeOfString:@"约"];
                    if ([tmpDisFordistance length]>=startRange.location+1) {
                        tmpDisFordistance=[tmpDisFordistance substringFromIndex:startRange.location+1];
                        NSRange endRange=[tmpDisFordistance rangeOfString:@"分钟"];
                        if ([disStr length]>=endRange.location) {
                            distanceStr=[tmpDisFordistance substringToIndex:endRange.location];
                        }
                    }
                    
                    [self setStationMarker:7-[busInfo[@"stationNo"] intValue]
                               andDistance:distanceStr
                          andCountDownTime:countDownTimeStr];
                }
            }
            
        }else{
            self.bottomTipLbl.text=@"下一班预计发车时间:";
            CGFloat bottomTipWidth=[self.bottomTipLbl.text sizeWithFont:[UIFont systemFontOfSize: BottomTip_Label_FontSize]].width;
            self.bottomNextTimeLbl.frame=CGRectMake(bottomTipWidth, BottomTip_Label_Origin_Y, BottomTip_Label_Width, BottomTip_Label_Height);
            self.bottomNextTimeLbl.text=responseDic[@"msg"];
        }
        
    }];
    [request startAsynchronous];
}

- (void)clear{
    for (NSObject *subViewObj in self.GCContainerViewArray) {
        [(UIView*)subViewObj removeFromSuperview];
    }
}

@end
