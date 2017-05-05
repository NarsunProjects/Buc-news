//
//  Notifications.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "Notifications.h"

@implementation Notifications


-(id) initWithiD:(NSString*)iD  andtotal_comments: (NSString*)total_comments andcaption:  (NSString*)caption andcreated_date:  (NSString*)created_date andmedia_url:  (NSString*)media_url anddescr:  (NSString*)descr{
    self = [super init];
    if (self) {
        
        _iD = iD;
        _total_comments =total_comments;
        _caption = caption;
        _created_date =created_date;
        _media_url = media_url;
        _descr = descr;
    }
    return self;
    
}
@end
