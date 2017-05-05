//
//  HomeTableViewCell.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 03/05/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *hImage;
@property (strong, nonatomic) IBOutlet UILabel *hlabel;
@property (strong, nonatomic) IBOutlet UILabel *hdate;
@property (strong, nonatomic) IBOutlet UILabel *hcomment;

@end
