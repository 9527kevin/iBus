//
//  BusDynamicStateOfLineController.m
//  iBus-iPhone
//
//  Created by yanghua on 5/25/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import "StationMapInfoController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "StationDao.h"

typedef enum {
    TAG_TOOLBAR_NORMAL=1000,
    TAG_TOOLBAR_TERRAIN=1001,
    TAG_TOOLBAR_HYBRID=1002
}TAGS;

@interface StationMapInfoController ()

@property (nonatomic,retain) GMSMarker      *marker;
@property (nonatomic,retain) NSDictionary   *stationInfo;
@property (nonatomic,retain) GMSMapView     *mapView;

@property (nonatomic,retain) UIButton       *normalTypeBtn;
@property (nonatomic,retain) UIButton       *terrainTypeBtn;
@property (nonatomic,retain) UIButton       *hybridTypeBtn;

@property (nonatomic,assign) TAGS           currentSelectedTag;

@end

@implementation StationMapInfoController

- (void)dealloc{
    [_identifier release],_identifier=nil;
    [_lineId release],_lineId=nil;
    [_marker release],_marker=nil;
    
    [super dealloc];
}

- (void)loadView{
    [self initMapAndCreateCenterMarker];
    [self initToolBars];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavLeftBackButton];
    self.navigationItem.title=[NSString stringWithFormat:@"%@-地理位置",
                               self.stationInfo[@"stationName"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods -
- (void)initMapAndCreateCenterMarker{
    
    double center_log;
    double center_lat;
    int zoom;
    
    self.stationInfo=[StationDao getStationInfoWithLineId:self.lineId
                                            andIdentifier:self.identifier
                                               andOrderNo:[NSNumber numberWithInt:self.stationNo]];
    
    if (self.stationInfo) {
        center_log=[self.stationInfo[@"stationLog"] doubleValue] / Default_Div_Time;
        center_lat=[self.stationInfo[@"stationLat"] doubleValue] / Default_Div_Time;
        
        zoom=16;
    }else{
        center_log=Log_Default;
        center_lat=Lat_Default;
        zoom=Default_Map_Zoom;
    }
    
    //transform earth to mars
    MarsGeodetic mapGeodetic=[MapHelper transformWithWGLat:center_lat
                                                  andWGLon:center_log];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapGeodetic.lat
                                                            longitude:mapGeodetic.log
                                                                 zoom:zoom];
    _mapView = [GMSMapView mapWithFrame:CGRectZero
                                 camera:camera];
    self.mapView.mapType=kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton=YES;
    self.mapView.settings.myLocationButton=YES;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    _marker = [[GMSMarker alloc] init];
    self.marker.position = CLLocationCoordinate2DMake(mapGeodetic.lat,mapGeodetic.log);
    self.marker.title = [NSString stringWithFormat:Map_Title,self.stationInfo[@"stationName"]];
    self.marker.snippet = Map_Snippet;
    self.marker.icon=[UIImage imageNamed:@"marker_car.png"];
    self.marker.map = self.mapView;
    
}

- (void)initToolBars{
    //normal
    _normalTypeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.normalTypeBtn.frame=ToolBar_Button_Normal_Frame;
    [self.normalTypeBtn setBackgroundImage:[UIImage imageNamed:@"normal.png"]
                                  forState:UIControlStateNormal];
    [self.normalTypeBtn setBackgroundImage:[UIImage imageNamed:@"normal_hl.png"]
                                  forState:UIControlStateHighlighted];
    [self.normalTypeBtn setBackgroundImage:[UIImage imageNamed:@"normal_hl.png"]
                                  forState:UIControlStateSelected];
    [self.normalTypeBtn addTarget:self
                           action:@selector(toolBar_Button_touchUpInside:)
                 forControlEvents:UIControlEventTouchUpInside];
    self.normalTypeBtn.tag=TAG_TOOLBAR_NORMAL;
    [self.view addSubview:self.normalTypeBtn];
    
    //terrain
    _terrainTypeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.terrainTypeBtn.frame=ToolBar_Button_Terrain_Frame;
    [self.terrainTypeBtn setBackgroundImage:[UIImage imageNamed:@"terrain.png"]
                                   forState:UIControlStateNormal];
    [self.terrainTypeBtn setBackgroundImage:[UIImage imageNamed:@"terrain_hl.png"]
                                   forState:UIControlStateHighlighted];
    [self.terrainTypeBtn setBackgroundImage:[UIImage imageNamed:@"terrain_hl.png"]
                                   forState:UIControlStateSelected];
    [self.terrainTypeBtn addTarget:self
                            action:@selector(toolBar_Button_touchUpInside:)
                  forControlEvents:UIControlEventTouchUpInside];
    self.terrainTypeBtn.tag=TAG_TOOLBAR_TERRAIN;
    [self.view addSubview:self.terrainTypeBtn];
    
    //hybrid
    _hybridTypeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.hybridTypeBtn.frame=ToolBar_Button_Hybrid_Frame;
    [self.hybridTypeBtn setBackgroundImage:[UIImage imageNamed:@"hybrid.png"]
                                  forState:UIControlStateNormal];
    [self.hybridTypeBtn setBackgroundImage:[UIImage imageNamed:@"hybrid_hl.png"]
                                  forState:UIControlStateHighlighted];
    [self.hybridTypeBtn setBackgroundImage:[UIImage imageNamed:@"hybrid_hl.png"]
                                  forState:UIControlStateSelected];
    [self.hybridTypeBtn addTarget:self
                           action:@selector(toolBar_Button_touchUpInside:)
                 forControlEvents:UIControlEventTouchUpInside];
    self.hybridTypeBtn.tag=TAG_TOOLBAR_HYBRID;
    [self.view addSubview:self.hybridTypeBtn];
    
    self.normalTypeBtn.selected=YES;
    self.currentSelectedTag=TAG_TOOLBAR_NORMAL;
}

- (void)toolBar_Button_touchUpInside:(id)sender{
    UIButton *toolBarBtn=(UIButton*)sender;
    switch (toolBarBtn.tag) {
        case TAG_TOOLBAR_NORMAL:
            self.mapView.mapType=kGMSTypeNormal;
            break;
            
        case TAG_TOOLBAR_TERRAIN:
            self.mapView.mapType=kGMSTypeTerrain;
            break;
            
        case TAG_TOOLBAR_HYBRID:
            self.mapView.mapType=kGMSTypeHybrid;
            break;
            
        default:
            break;
    }
    
    //unselect prec
    ((UIButton*)[self.view viewWithTag:self.currentSelectedTag]).selected=NO;
    
    //select current
    toolBarBtn.selected=YES;
    self.currentSelectedTag=toolBarBtn.tag;
}

//- (void)drawLineOnMap{
//    NSMutableDictionary *stationInfo=[StationDao getStationInfoWithLineId:self.lineId
//                                                            andIdentifier:self.identifier
//                                                               andOrderNo:[NSNumber numberWithInt:self.stationNo]];
//    
//    GMSMutablePath *path = [GMSMutablePath path];
//    if (stationInfo[@"stationLat"] && stationInfo[@"stationLog"]) {
//        MarsGeodetic mapGeodetic=[MapHelper transformWithWGLat:[stationInfo[@"stationLat"] doubleValue] / Default_Div_Time
//                                                      andWGLon:[stationInfo[@"stationLog"] doubleValue] / Default_Div_Time];
//        [path addCoordinate:CLLocationCoordinate2DMake(mapGeodetic.lat,mapGeodetic.log)];
//    }
//    
//    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
//    [rectangle setStrokeColor:[UIColor redColor]];
//    [rectangle setStrokeWidth:4.0f];
//    rectangle.map = self.mapView;
//}

@end
