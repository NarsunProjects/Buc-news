//
//  DetailViewController.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notifications.h"
@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    IBOutlet UILabel *caption;
    IBOutlet UITableView *table;

    IBOutlet UITextField *txt_comment;
    IBOutlet UILabel *date;
    IBOutlet UIImageView *imageview;
    NSMutableArray *commentsArray;
    NSString *token;
    
    
}

@property (nonatomic, retain) Notifications
*object;
@end
