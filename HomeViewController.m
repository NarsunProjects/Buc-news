//
//  HomeViewController.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 24/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "AFNetworking.h"
#import "StaticData.h"
#import "MBProgressHUD.h"
#import "Notifications.h"
#import "CollectionViewCell.h"
#import "HomeTableViewCell.h"
#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HomeViewController (){

    NSString *token;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        SWRevealViewController * revealViewController = self.revealViewController;
        if (revealViewController) {
    
            [menuButton setTarget:self.revealViewController];
            [menuButton setAction:@selector(revealToggle:)];
            [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
            [revealViewController panGestureRecognizer];
            [revealViewController tapGestureRecognizer];
        }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self GetNoti];
}

-(void)GetNoti{
    collectionArray = [[NSMutableArray alloc]init];
    MBProgressHUD *hud = [self setUpProgressBar:self.view];
    [hud show:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"] == nil){
    
        token = @"iOSabcdefgh";
        
    }else{
        
        token = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
    }
     NSDictionary *Params = @{@"X-TOKEN":[[NSUserDefaults standardUserDefaults] stringForKey:@"access_key"],@"X-DEVICE":token};
    [manager POST:@"http://buccollege.com/notify2/public/api/notificationsRecieved" parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if([[dictionary valueForKey:@"status"] isEqual:[NSNumber numberWithInt:0]]){
            [self displayAlert:[dictionary valueForKey:@"message"]];
        }else{
            for(NSDictionary *dic in [dictionary valueForKey:@"data"]){
                
                NSString *iD = [NSString stringWithFormat:@"%@",[dic valueForKey:@"id"]];
                NSString *total_comments = [NSString stringWithFormat:@"%@",[dic valueForKey:@"total_comments"]];
                NSString *caption = [NSString stringWithFormat:@"%@",[dic valueForKey:@"caption"]];
                NSString *created_date = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_date"]];
                NSString *media_url = [NSString stringWithFormat:@"%@",[dic valueForKey:@"media_url"]];
                NSString *descr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"description"]];
                
                Notifications *obj = [[Notifications alloc] initWithiD:(NSString*)iD  andtotal_comments: (NSString*)total_comments andcaption:  (NSString*)caption andcreated_date:  (NSString*)created_date andmedia_url:  (NSString*)media_url anddescr: (NSString*)descr];
                
                [collectionArray addObject:obj];
            }
            [table reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        NSString *string = @"Cannot estabilish a connection with server";
        [self displayAlert:string];
        
    }];
    
      


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return collectionArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"mCell"];
    Notifications *ab = [collectionArray objectAtIndex:indexPath.row];
    cell.hlabel.text = ab.caption;
    cell.hdate.text = ab.created_date;
    cell.hcomment.text = ab.total_comments;
    SDWebImageDownloader * downlonder = [SDWebImageDownloader sharedDownloader];
    [downlonder downloadImageWithURL:[NSURL URLWithString:ab.media_url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
    } completed:^(UIImage* image, NSData* data, NSError *error, BOOL finished){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (image&&finished) {
                
                cell.hImage.image = image;
            }
            
        });
        
    }];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    
    // Get reference to the destination view controller
    DetailViewController *vc = [segue destinationViewController];
    
    NSIndexPath *index = [table indexPathForCell:sender];
    
    // Pass any objects to the view controller here, like...
    vc.object = [collectionArray objectAtIndex:index.row];
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(50, 50);
//}

-(void)displayAlert:(NSString *)Message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BUCNEWS" message:Message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alertView show];
    
}
-(MBProgressHUD *)setUpProgressBar:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [view addSubview:hud];
    hud.color = [UIColor whiteColor];
    hud.dimBackground = YES;
    return hud;
}

-(NSString *)parseDictionaryIntoGETParamLink:(NSDictionary *)param{
    NSArray *arrayOfParams = [param allKeys];
    NSString *paramURL = [NSString stringWithFormat:@"?%@=%@",[arrayOfParams objectAtIndex:0],[param objectForKey:[arrayOfParams objectAtIndex:0]]];
    for (NSInteger index=1; index<arrayOfParams.count; index++) {
        NSString *keyName = [arrayOfParams objectAtIndex:index];
        paramURL = [NSString stringWithFormat:@"%@&%@=%@",paramURL,keyName,[param objectForKey:keyName]];
    }
    return paramURL;
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
