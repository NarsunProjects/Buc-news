//
//  StaticData.m
//  RYPLS
//
//  Created by Curiologix on 12/14/15.
//  Copyright © 2015 Curiologix. All rights reserved.
//

#import "StaticData.h"

@implementation StaticData

@synthesize CustomerID, Description, DisplayPicture, Distance,  EndAddress, Maker ,Model, Phone, Rating, RequestId, StartAddress,TOR,Year,end_latitude,latitude,longitude,request_status,name,end_longitude,Tokenn,loginStatus;

static StaticData *_instance;

- (id) init {
    if (self = [super init]) {
    }
    return self;
}

+ (StaticData *)instance {
    if (!_instance) {
        _instance = [[StaticData alloc] init];
    }
    return _instance;
}

+ (void)initStaticData {
//    [StaticData instance].deviceID = @"";
//    [StaticData instance].serverTimeout = 30 * 1000;
//    //[StaticData instance].baseUrl = @"http://reeln.webdesigninhoustontexas.com/";
//    [StaticData instance].baseUrl = @"http://rlyps.curiologix.com/public/";
//    [StaticData instance].imageUrl = @"http://rlyps.curiologix.com/public/images/[image_name";
//    [StaticData instance].noInternetMessage = @"Please check your internet connection!";
//    [StaticData instance].secureKey = @"";
    
}
+(MBProgressHUD *)setUpProgressBar:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [view addSubview:hud];
    hud.color = [UIColor whiteColor];
    hud.dimBackground = YES;
    return hud;
}


@end
