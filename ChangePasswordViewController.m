//
//  ChangePasswordViewController.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking.h"
#import "StaticData.h"
#import "MBProgressHUD.h"
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changepassword:(id)sender {
    
    if([txt_old.text length]==0){
        [self displayAlert:@"Please enter your Old Password."];
        
    }else if([txt_new.text length]==0){
        [self displayAlert:@"Please enter your New Password."];
        
    }else if([txt_confirm.text length]==0){
        [self displayAlert:@"Please enter your Confirm Password."];
        
    }else if(![txt_confirm.text isEqualToString:txt_new.text]){
        [self displayAlert:@"Password doesn't Match With Confirm Password."];
        
    }
    else{
        
        [self passwordApi];
        
    }
   
}

-(void)passwordApi{
    
    MBProgressHUD *hud = [self setUpProgressBar:self.view];
    [hud show:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    NSDictionary *Params = @{@"new_pwd":txt_new.text,@"old_pwd":txt_old.text,@"user_id":[[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"]};
    [manager POST:@"http://buccollege.com/notify2/public/api/changePassword" parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if([[dictionary valueForKey:@"status"] isEqual:[NSNumber numberWithInt:0]]){
            [self displayAlert:[dictionary valueForKey:@"message"]];
        }else{
           [self displayAlert:[dictionary valueForKey:@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        NSString *string = @"Cannot estabilish a connection with server";
        [self displayAlert:string];
        
    }];

}

-(void)displayAlert:(NSString *)Message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BUCNEWS" message:Message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alertView show];
    
}


-(MBProgressHUD *)setUpProgressBar:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [view addSubview:hud];
    hud.color = [UIColor whiteColor];
    hud.dimBackground = YES;
    return hud;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
