//
//  AppDelegate.m
//  BUCNews
//
//  Created by Mudassar on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "AppDelegate.h"
@import Firebase;
@import FirebaseMessaging;
#include <AudioToolbox/AudioToolbox.h>
#import "HomeViewController.h"
#import "SWRevealViewController.h"
 
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
            return YES;
    
}

- (void)tokenRefreshNotification:(NSNotification *)notification {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    [[NSUserDefaults standardUserDefaults]setValue:refreshedToken forKey:@"access_token"];
    //[self connectToFCM];
    // Connect to FCM since connection may have failed when attempted before having a token.
    
    // TODO: If necessary send token to application server.
}
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings
                                     *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
}



-(void)application:(UIApplication* )application didRegisterForRemoteNotificationsWithDeviceToken:(NSData* )deviceToken{
//    if (!isProd) {
//        [[FIRInstanceID instanceID] setAPNSToken:deviceToken
//                                            type:FIRInstanceIDAPNSTokenTypeSandbox];
//    }else{
        [[FIRInstanceID instanceID] setAPNSToken:deviceToken
                                            type:FIRInstanceIDAPNSTokenTypeProd];
    //}
    
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    
    // NSString * token = [NSString stringWithFormat:@"%@", refreshedToken];
    
    //Format token as you need:
    
    // token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    // token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    // [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
    
    if (isUpdated) {
        return;
    }
   
    NSLog(@"InstanceID token: %@", refreshedToken);
    
    [[NSUserDefaults standardUserDefaults]setValue:refreshedToken forKey:@"access_token"];

    
 
    
    //[self updateTutorTokenWithTokenID:refreshedToken];
}


-(void)application:(UIApplication* )application didFailToRegisterForRemoteNotificationsWithError:(NSError* )error{
    
}


//-(void)updateTutorTokenWithTokenID:(NSString *)token{
//    NSDictionary *param = @{@"did":[NSNumber numberWithInteger:self.userObj.userID.integerValue], @"gcm":token};
//    [NetworkManager updateGCMTokenionWithParam:<#(NSDictionary *)#> success:<#^(NSString *Status)success#> apiFailure:<#^(NSString *errorString)apiFailure#> failure:<#^(NSString *errorString)failure#>:param success:^(NSString *success){
//
//        isUpdated = YES;
//
//    } failure:^(NSString *failure){
//
//        [self updateTutorTokenWithTokenID:token];
//    } apiFailure:^(NSError *error){
//
//        [self updateTutorTokenWithTokenID:token];
//
//    }];
//}


-(void)application:(UIApplication* )application didReceiveRemoteNotification:(NSDictionary* )userInfo{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
   
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    
        UIApplicationState state = [application applicationState];
        if (state == UIApplicationStateActive)
        {
    
            SystemSoundID soundID;
            CFBundleRef mainBundle = CFBundleGetMainBundle();
            CFURLRef ref = CFBundleCopyResourceURL(mainBundle, (CFStringRef)@"mySoundName.wav", NULL, NULL);
            AudioServicesCreateSystemSoundID(ref, &soundID);
            AudioServicesPlaySystemSound(soundID);
            NSString *cancelTitle = @"Cancel";
            NSString *showTitle = @"Show";
            NSDictionary *Title = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
            NSString *message = [Title valueForKey:@"title"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notification!"
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:cancelTitle
                                                      otherButtonTitles:showTitle, nil];
            [alertView show];
        }
        else {
    
        }
    
       [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        //completionHandler(UIBackgroundFetchResultNoData);
        handler( UIBackgroundFetchResultNewData);
    
    
}
//-(void)application:(UIApplication* )application didReceiveRemoteNotification:(NSDictionary* )userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
//    

//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        SWRevealViewController *main = (SWRevealViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        
        self.window.rootViewController = main;
        
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    NSLog(@"%@", userInfo);
    
    completionHandler( UNNotificationPresentationOptionAlert );
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    //    completionHandler(UNNotificationPresentationOptionAlert);
}
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
//{
//    NSLog( @"Handle push from foreground" );
//    // custom code to handle push while app is in the foreground
//    NSLog(@"%@", notification.request.content.userInfo);
//}
//
//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
//{
//    NSLog( @"Handle push from background or closed" );
//    // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background
//    NSLog(@"%@", response.notification.request.content.userInfo);
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
