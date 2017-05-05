//
//  HomeViewController.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITableView *table;
  
    NSMutableArray *collectionArray;

    IBOutlet UIBarButtonItem *menuButton;

}

@end
