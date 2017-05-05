//
//  ViewController.h
//  BUCNews
//
//  Created by Mudassar on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    IBOutlet UITextField *txt_cpassword;
    IBOutlet UITextField *txt_password;
    IBOutlet UITextField *txt_email;
    IBOutlet UITextField *txt_name;
    NSString *token;

}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *menuButton;


@end

