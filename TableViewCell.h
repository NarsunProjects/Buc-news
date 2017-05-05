//
//  TableViewCell.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *c_name;
@property (strong, nonatomic) IBOutlet UILabel *c_sender;
@property (strong, nonatomic) IBOutlet UILabel *c_date;
@property (strong, nonatomic) IBOutlet UIImageView *c_image;

@end
