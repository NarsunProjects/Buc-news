//
//  ContactViewController.h
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 25/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface ContactViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,MFMailComposeViewControllerDelegate>{


    IBOutlet MKMapView *map;

    IBOutlet UITableView *table;
    NSArray *sectionArray;
    NSArray *innerData;
    NSArray *innerData2;
}

@end
