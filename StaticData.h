//
//  StaticData.h
//  RYPLS
//
//  Created by Curiologix on 12/14/15.
//  Copyright © 2015 Curiologix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface StaticData : NSObject{

}

@property (nonatomic, retain) NSString *CustomerID;
@property (nonatomic, retain) NSString *Description;

@property (nonatomic, retain) NSString *DisplayPicture;
@property (nonatomic, retain) NSString *Distance;
@property (nonatomic, retain) NSString *EndAddress;

@property (nonatomic, retain) NSString *Maker;

@property (nonatomic, retain) NSString *Model;

@property (nonatomic, retain) NSString *Phone;
@property (nonatomic, retain) NSString *Rating;
@property (nonatomic, retain) NSString *RequestId;
@property (nonatomic, retain) NSString *StartAddress;
@property (nonatomic, retain) NSString *TOR;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *Year;
@property (nonatomic, retain) NSString *end_latitude;
@property (nonatomic, retain) NSString *end_longitude;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *request_status;
@property (nonatomic, retain) NSString *Tokenn;
@property (nonatomic, retain) NSString *loginStatus;



+ (StaticData *)instance;
+ (void)initStaticData;
+(MBProgressHUD *)setUpProgressBar:(UIView *)view;
@end
