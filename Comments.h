//
//  Comments.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject
@property (strong, nonatomic) NSString *nam;
@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSString *c_date;

-(id) initWithnam:(NSString*)nam  andsender: (NSString*)sender andc_date:  (NSString*)c_date;
@end
