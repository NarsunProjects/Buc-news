//
//  ContactViewController.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 25/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self displayMapView];
    sectionArray = [NSArray arrayWithObjects:@"Reception", @"Dean office", nil];
    innerData = [NSArray arrayWithObjects:@"Phone", @"Email", nil];
    innerData2 = [NSArray arrayWithObjects:@"Phone",@"Fax", @"Email", nil];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayMapView
{
    map.delegate = self;
    map.mapType = MKMapTypeStandard;
    //mapview.showsUserLocation = YES;
    
    CLLocation *detination = [[CLLocation alloc] initWithLatitude:24.236680 longitude:55.896619];
    
    //    double distance=[details.Distance doubleValue];
    //    if(details.Distance<1000)
    //        lbl_distance.text = [NSString stringWithFormat:@"Distance:%f m",details.Distance];
    //    else

    
    map.centerCoordinate = detination.coordinate;
    
    MKCoordinateRegion region;
    CLLocation *locObj = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(detination.coordinate.latitude, detination.coordinate.longitude)
                                                       altitude:0
                                             horizontalAccuracy:0
                                               verticalAccuracy:0
                                                      timestamp:[NSDate date]];
    float spanX = 0.5;
    float spanY = 0.5;
    
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    
    region.center = locObj.coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta  = spanX; // values for zoom
    span.longitudeDelta = spanY;
    region.span = span;
    [map setRegion:region animated:YES];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = detination.coordinate;
    myAnnotation.title = @"Buraimi University College";
    myAnnotation.subtitle = @"";
    [map addAnnotation:myAnnotation];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self->innerData.count;
    if (section == 1)
        return self->innerData2.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.section == 0)
        cell.textLabel.text = [innerData objectAtIndex:indexPath.row];
    
    if (indexPath.section == 1)
        cell.textLabel.text = [innerData2 objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma stuff I added

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return [sectionArray objectAtIndex:0];
    if (section == 1)
         return [sectionArray objectAtIndex:1];
    return @"undefined";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // you can use "indexPath" to know what cell has been selected as the following
    if(indexPath.section == 0){
        if(indexPath.row == 0){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"25657666"]]];
        }else{
        
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
            mailCont.mailComposeDelegate = self;
            
            [mailCont setSubject:@""];
            [mailCont setToRecipients:[NSArray arrayWithObject:@"malmamari@buc.edu.om"]];
            [mailCont setMessageBody:@"" isHTML:NO];
            
            [self presentModalViewController:mailCont animated:YES];
            
        }
        }
        
    }else{
        
        if(indexPath.row == 0){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"25657611"]]];
        }else if(indexPath.row == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",@"25657600"]]];
        
        }else{
            
            if([MFMailComposeViewController canSendMail]) {
                MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
                mailCont.mailComposeDelegate = self;
                
                [mailCont setSubject:@""];
                [mailCont setToRecipients:[NSArray arrayWithObject:@"deanoffice@buc.edu.om"]];
                [mailCont setMessageBody:@"" isHTML:NO];
                
                [self presentModalViewController:mailCont animated:YES];
                
            }
        }
        
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
