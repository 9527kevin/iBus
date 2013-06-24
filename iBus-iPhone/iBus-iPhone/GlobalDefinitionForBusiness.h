//
//  GlobalDefinition.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>


//站点查询
#define Url_StationSearch \
@"http://112.2.33.3:7106/BusAndroid/android.do?command=toSsta&stationName=%@"

//线路列表
#define Url_BusLineList \
http://www.baidu.com

//线路详情
#define Url_DetailOfLine \
@"http://112.2.33.3:7106/BusAndroid/android.do?command=toLs&lineId=%@&inDown=1"

//线路换乘
#define Url_LineExchange \
@"http://112.2.33.3:7106//BusAndroid/android.do?command=toHcnt&sstation=%@&estation=%@"

//到站距离
//inDown:0/1
#define Url_DestinationDistance \
@"http://112.2.33.3:7106/BusAndroid/android.do?command=toDis&lineId=%@&inDown=%@&stationNo=%d"

//站点模糊匹配
#define Url_StationFuzzyQuery \
@"http://112.2.33.3:7106/BusAndroid/android.do?command=toSway&stationName=%@"

//线路模糊匹配
#define Url_LineFuzzyQuery \
@"http://112.2.33.3:7106//BusAndroid/android.do?command=toHcSta&sstation=%@&estation=%@"

#define Dynamic_Station_List_Count 8
//刷新频率

//setting keys
#define Setting_Key_DefaultLine         @"默认线路"
#define Setting_Key_FollowStation       @"关注站点"
#define Setting_Key_RefreshFrequency    @"刷新频率"

/******************************Messages*******************************/
#define Notification_Of_LineList        @"Notification_Of_LineList"

#define Notification_For_AtSomebody     @"Notification_For_AtSomebody"
