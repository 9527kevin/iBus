//
//  GlobalDefinition.h
//  iBus-iPhone
//
//  Created by yanghua on 5/19/13.
//  Copyright (c) 2013 yanghua. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
--站点查询：http://112.2.33.3:7106/BusAndroid/android.do?command=toSway&stationName=军师巷
--线路选择：http://112.2.33.3:7106/BusAndroid/android.do?command=toSsta&stationName=军师巷
--线路详情：http://112.2.33.3:7106/BusAndroid/android.do?command=toLs&lineId=453&inDown=1
--各车辆距离站点信息：http://112.2.33.3:7106/BusAndroid/android.do?command=toDis&lineId=453&inDown=1&stationNo=26
--站点查询：http://112.2.33.3:7106//BusAndroid/android.do?command=toHcnt&sstation=东山总站&estation=军师巷
换成建议：http://112.2.33.3:7106/BusAndroid/android.do?command=toRet&flag=0&lineId=453&inDown=0
--模糊查询：http://112.2.33.3:7106//BusAndroid/android.do?command=toHcSta&sstation=军师巷&estation=东山总站
 */


//站点查询
#define Url_StationSearch \
http://112.2.33.3:7106/BusAndroid/android.do?command=toSsta&stationName=%@

//线路列表
#define Url_BusLineList \
http://www.baidu.com

//线路详情
#define Url_DetailOfLine \
@"http://112.2.33.3:7106/BusAndroid/android.do?command=toLs&lineId=%@&inDown=1"

//线路换乘
#define Url_LineExchange \
http://112.2.33.3:7106//BusAndroid/android.do?command=toHcnt&sstation=%@&estation=%@

//到站距离
//inDown:0/1
#define Url_DestinationDistance \
http://112.2.33.3:7106/BusAndroid/android.do?command=toDis&lineId=%@&inDown=%@&stationNo=%@

//站点模糊匹配
#define Url_StationFuzzyQuery \
http://112.2.33.3:7106/BusAndroid/android.do?command=toSway&stationName=%@

//线路模糊匹配
#define Url_LineFuzzyQuery \
http://112.2.33.3:7106//BusAndroid/android.do?command=toHcSta&sstation=%@&estation=%@



