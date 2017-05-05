//
//  Notifications.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notifications : NSObject

@property (strong, nonatomic) NSString *iD;
@property (strong, nonatomic) NSString *total_comments;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) NSString *created_date;
@property (strong, nonatomic) NSString *media_url;
@property (strong, nonatomic) NSString *descr;
-(id) initWithiD:(NSString*)iD  andtotal_comments: (NSString*)total_comments andcaption:  (NSString*)caption andcreated_date:  (NSString*)created_date andmedia_url:  (NSString*)media_url anddescr:  (NSString*)descr;

@end
