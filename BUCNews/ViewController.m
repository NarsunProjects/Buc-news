//
//  ViewController.m
//  BUCNews
//
//  Created by Mudassar on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking.h"
#import "StaticData.h"
#import "MBProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    SWRevealViewController * revealViewController = self.revealViewController;
//    if (revealViewController) {
//        
//        [self.menuButton setTarget:self.revealViewController];
//        [self.menuButton setAction:@selector(revealToggle:)];
//        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
//        [revealViewController panGestureRecognizer];
//        [revealViewController tapGestureRecognizer];
//    }

}

- (IBAction)submit:(id)sender {
    
    BOOL valid = [self validateEmailWithString:txt_email.text];
    
    if([txt_name.text length]==0){
        [self displayAlert:@"Please enter your Name."];
    }else if([txt_email.text length]==0){
        [self displayAlert:@"Please enter your Email."];
        
    }else if([txt_password.text length]==0){
        [self displayAlert:@"Please enter your Password."];
        
    }else if([txt_cpassword.text length]==0){
        [self displayAlert:@"Please confirm your Password."];
        
    }
    else if([txt_password.text length]<8){
        [self displayAlert:@"Password should have aleast 8 characters."];
        
    }  else if(!valid){
        
        [self displayAlert:@"Please enter a valid Email."];
        
    }else if(![txt_password.text isEqualToString:txt_cpassword.text]){
        
        [self displayAlert:@"Password doesn't Match With Confirm Password."];
        
    }else{
        
        [self SignUpApi];
        
    }
}

-(void)SignUpApi{
  
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
    NSDictionary *Params = @{@"email":txt_email.text,@"password":txt_password.text,@"app_version":@"1.0",@"name":txt_name.text,@"device_id":token,@"os_type":@"iOS",@"os_version":@"6.0",@"hardware":@"iOS"};
    [manager POST:@"http://buccollege.com/notify2/public/api/register" parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
                NSError *error;
               NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
            [self displayAlert:[dictionary valueForKey:@"message"]];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(MBProgressHUD *)setUpProgressBar:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [view addSubview:hud];
    hud.color = [UIColor whiteColor];
    hud.dimBackground = YES;
    return hud;
}
- (IBAction)back:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
