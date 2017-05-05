//
//  ChangePasswordViewController.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>{

    IBOutlet UITextField *txt_old;
    
    IBOutlet UITextField *txt_new;

    IBOutlet UITextField *txt_confirm;
}

@end
