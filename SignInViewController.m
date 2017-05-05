//
//  SignInViewController.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "SignInViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking.h"
#import "StaticData.h"
#import "MBProgressHUD.h"
@interface SignInViewController (){

    NSString *token;
}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"email"]!=nil &&[[NSUserDefaults standardUserDefaults] stringForKey:@"password"]!=nil){
        txt_email.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
        txt_password.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
        [self Signin:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Signin:(id)sender {
   
    BOOL valid = [self validateEmailWithString:txt_email.text];
    if([txt_email.text length]==0){
        [self displayAlert:@"Please enter your Email."];
        
    }else if([txt_password.text length]==0){
        [self displayAlert:@"Please enter your Password."];
        
    }else{
        
        [self SigninApi];
        
    }
    
}

-(void)SigninApi{
    
    MBProgressHUD *hud = [self setUpProgressBar:self.view];
    [hud show:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"] == nil){
        
        token = @"iOSabcdefgh";
        
    }else{
        
        token = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
    }
    NSDictionary *Params = @{@"email":txt_email.text,@"password":txt_password.text,@"app_version":@"1.0",@"device_id":token,@"os_type":@"iOS",@"os_version":@"6.0",@"hardware":@"iOS"};
    [manager POST:@"http://buccollege.com/notify2/public/api/login" parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSError *error;
        [[NSUserDefaults standardUserDefaults]setValue:txt_email.text forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setValue:txt_password.text forKey:@"password"];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
       
        NSString *str = [dictionary valueForKey:@"message"];
        if([str isEqualToString:@"Login successfully"]){
            NSDictionary *data = [dictionary valueForKey:@"data"];
            [[NSUserDefaults standardUserDefaults]setValue:[data valueForKey:@"user_id"] forKey:@"user_id"];
             [[NSUserDefaults standardUserDefaults]setValue:[data valueForKey:@"access_token"] forKey:@"access_key"];
           
            [self performSegueWithIdentifier:@"login" sender:self];
        }else{
            
            [self displayAlert:str];
        
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        NSString *string = @"Cannot estabilish a connection with server";
        [self displayAlert:string];
        
    }];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
