//
//  SideMenuController.m
//  BUCNews
//
//  Created by Mudassar on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "SideMenuController.h"
#import "AboutViewController.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "PortalViewController.h"
#import "ContactViewController.h"
#import "SignInViewController.h"
#import "ChangePasswordViewController.h"
@interface SideMenuController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation SideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _menuItems = @[@"ImageCell", @"recentNews", @"aboutCollege",@"studentPortal",@"contactUS",@"Settings",@"logout",@"Develop"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _menuItems.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
        return 137;
        
    }else if (indexPath.row==1){
        
        return 40;
        
    }else if (indexPath.row==2){
        return 40;
    }else if (indexPath.row==3){
        return 40;
    }else if (indexPath.row==4){
        return 40;
    }else if (indexPath.row==5){
        return 40;
    }else if (indexPath.row==6){
        return 40;
    }
    else if (indexPath.row==7){
        return 51;
    }
    
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [_menuItems objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (void)tableView:(UITableView* )tableView didSelectRowAtIndexPath:(NSIndexPath* )indexPath
{
    if (indexPath.row == 1) {
        
   
      
    }
    if (indexPath.row == 2) {
        
        AboutViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutViewController"];
        UINavigationController * navControler = [[UINavigationController alloc]initWithRootViewController:viewController];
        navControler.navigationBar.barTintColor = [UIColor colorWithRed:64/255.0 green:0/225.0 blue:128/255.0 alpha:1.0];
        
       
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(showInfo:)];

        viewController.navigationItem.title=@"About College";
        
        viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        [navControler setViewControllers:@[viewController] animated:YES];
        
        [self.revealViewController setFrontViewController:navControler];
        [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
    
    if (indexPath.row==3) {
        
        PortalViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PortalViewController"];
        UINavigationController * navControler = [[UINavigationController alloc]initWithRootViewController:viewController];
        navControler.navigationBar.barTintColor = [UIColor colorWithRed:64/255.0 green:0/225.0 blue:128/255.0 alpha:1.0];
    
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(showInfo:)];
       
        viewController.navigationItem.title=@"Student Portal";
        
         viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        
        
        [navControler setViewControllers:@[viewController] animated:YES];
        
        [self.revealViewController setFrontViewController:navControler];
        [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    }
//
    if (indexPath.row==4){
        
        ContactViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContactViewController"];
        UINavigationController * navControler = [[UINavigationController alloc]initWithRootViewController:viewController];
        navControler.navigationBar.barTintColor = [UIColor colorWithRed:64/255.0 green:0/225.0 blue:128/255.0 alpha:1.0];
       
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(showInfo:)];
        
         viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        viewController.navigationItem.title=@"Contact Us";
        [navControler setViewControllers:@[viewController] animated:YES];
        
        [self.revealViewController setFrontViewController:navControler];
        [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        
        
    }
//
    if (indexPath.row==5){
       
        ChangePasswordViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        UINavigationController * navControler = [[UINavigationController alloc]initWithRootViewController:viewController];
        navControler.navigationBar.barTintColor = [UIColor colorWithRed:64/255.0 green:0/225.0 blue:128/255.0 alpha:1.0];
        
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(showInfo:)];
        
        viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        viewController.navigationItem.title=@"Change Password";
        [navControler setViewControllers:@[viewController] animated:YES];
        
        [self.revealViewController setFrontViewController:navControler];
        [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];

    }
    if (indexPath.row==6){
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"password"];
        
        SignInViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SignInViewController"];
        
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
//
//    if (indexPath.row==5){
//        
//        // check whether user login or not
//        
//        BOOL isLogin = [[NSUserDefaults standardUserDefaults]boolForKey:@"ButtonClicked"];
//        
//        if (isLogin ) {
//            
//            [self.tabBarController setSelectedIndex:1]; // open 2nd tabbar
//        }else{
//            
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"BeautyDoc" message:@"Please Register In App" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            
//            
//        }
//    }
    
}
-(IBAction)showInfo:(id)sender{
    
    UIStoryboard * storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController * SWRVC = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:SWRVC animated:YES completion:nil];
    
}

@end
