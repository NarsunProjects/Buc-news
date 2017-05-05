//
//  AppDelegate.h
//  BUCNews
//
//  Created by Mudassar on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>{

    BOOL isProd;
    BOOL isUpdated;
}

@property (strong, nonatomic) UIWindow *window;


@end

