//
//  CollectionViewCell.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *comment;

@end
