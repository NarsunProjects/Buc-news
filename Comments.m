//
//  Comments.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "Comments.h"

@implementation Comments

-(id) initWithnam:(NSString*)nam  andsender: (NSString*)sender andc_date:  (NSString*)c_date{
    self = [super init];
    if (self) {
        
        _nam = nam;
        _sender =sender;
        _c_date = c_date;
    }
    return self;
    
}
@end
