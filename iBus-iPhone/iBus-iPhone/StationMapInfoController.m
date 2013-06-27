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

@interface StationMapInfoController ()

@property (nonatomic,retain) GMSMarker      *marker;
@property (nonatomic,retain) NSDictionary   *stationInfo;
@property (nonatomic,retain) GMSMapView     *mapView;

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initNavLeftBackButton];
    self.navigationItem.title=[NSString stringWithFormat:@"%@-地理位置",self.stationInfo[@"stationName"]];
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
    MarsGeodetic mapGeodetic=[MapHelper transformWithWGLat:center_lat andWGLon:center_log];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mapGeodetic.lat
                                                            longitude:mapGeodetic.log
                                                                 zoom:zoom];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    _marker = [[GMSMarker alloc] init];
    self.marker.position = CLLocationCoordinate2DMake(mapGeodetic.lat,mapGeodetic.log);
    self.marker.title = [NSString stringWithFormat:Map_Title,self.stationInfo[@"stationName"]];
    self.marker.snippet = Map_Snippet;
    self.marker.map = self.mapView;
    
}

- (void)drawLineOnMap{
    NSMutableDictionary *stationInfo=[StationDao getStationInfoWithLineId:self.lineId
                                                            andIdentifier:self.identifier
                                                               andOrderNo:[NSNumber numberWithInt:self.stationNo]];
    
    GMSMutablePath *path = [GMSMutablePath path];
    if (stationInfo[@"stationLat"] && stationInfo[@"stationLog"]) {
        MarsGeodetic mapGeodetic=[MapHelper transformWithWGLat:[stationInfo[@"stationLat"] doubleValue] / Default_Div_Time
                                                      andWGLon:[stationInfo[@"stationLog"] doubleValue] / Default_Div_Time];
        [path addCoordinate:CLLocationCoordinate2DMake(mapGeodetic.lat,mapGeodetic.log)];
    }
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    [rectangle setStrokeColor:[UIColor redColor]];
    [rectangle setStrokeWidth:4.0f];
    rectangle.map = self.mapView;
}

@end
