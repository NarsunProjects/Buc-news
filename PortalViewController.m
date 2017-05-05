//
//  PortalViewController.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 25/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "PortalViewController.h"

@interface PortalViewController ()

@end

@implementation PortalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    NSURL *targetURL = [NSURL URLWithString:@"http://sisweb.buc.edu.om/portal/pls/portal/logsisw.cow_start"];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    activity.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    activity.hidden = YES;
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
    activity.hidden = YES;
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
