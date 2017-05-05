//
//  DetailViewController.m
//  BUCNews
//
//  Created by NARSUN-MAC-01 on 26/04/2017.
//  Copyright © 2017 Mudassar. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SWRevealViewController.h"
#import "AFNetworking.h"
#import "StaticData.h"
#import "MBProgressHUD.h"
#import "Notifications.h"
#import "CollectionViewCell.h"
#import "TableViewCell.h"
#import "Comments.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SDWebImageDownloader * downlonder = [SDWebImageDownloader sharedDownloader];
    [downlonder downloadImageWithURL:[NSURL URLWithString:_object.media_url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
    } completed:^(UIImage* image, NSData* data, NSError *error, BOOL finished){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (image&&finished) {
                
                imageview.image = image;
            }else{
                
                imageview.image = [UIImage imageNamed:@"no-image-available"];
            }
            
        });
        
    }];
    
    caption.text = _object.descr;
    date.text = _object.created_date;
    self.navigationController.navigationItem.title= _object.caption;
    [self GetComments];
}

-(void)GetComments{
    commentsArray = [[NSMutableArray alloc]init];
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
    NSDictionary *Params = @{@"X-TOKEN":[[NSUserDefaults standardUserDefaults] stringForKey:@"access_key"],@"X-DEVICE":token,@"nid":_object.iD};
    
    [manager POST:@"http://buccollege.com/notify2/public/api/commentsList" parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if([[dictionary valueForKey:@"status"] isEqual:[NSNumber numberWithInt:0]]){
            [self displayAlert:[dictionary valueForKey:@"message"]];
        }else{
            for(NSDictionary *dic in [dictionary valueForKey:@"data"]){
                
                NSString *nam = [NSString stringWithFormat:@"%@",[dic valueForKey:@"comments"]];
                NSString *sender = [NSString stringWithFormat:@"%@",[dic valueForKey:@"name"]];
                NSString *c_date = [NSString stringWithFormat:@"%@",[dic valueForKey:@"created_date"]];
                
                
                Comments *obj = [[Comments alloc] initWithnam:(NSString*)nam  andsender: (NSString*)sender andc_date:  (NSString*)c_date ];
                
                [commentsArray addObject:obj];
            }
            [table reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        NSString *string = @"Cannot estabilish a connection with server";
        [self displayAlert:string];
        
    }];
    
    
    
    
}
- (IBAction)sendComment:(id)sender {
    
    if([txt_comment.text length]==0){
    
        [self displayAlert:@"Please Type Your Comment."];
    }else{
        
        [self commentPostApi];
    }
}

-(void)commentPostApi{
    MBProgressHUD *hud = [self setUpProgressBar:self.view];
    [hud show:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    NSDictionary *Params = @{@"notification_id":_object.iD,@"comments":txt_comment.text,@"user_id":str};
    [manager POST:@"http://buccollege.com/notify2/public/api/comments" parameters:Params progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        if([[dictionary valueForKey:@"status"] isEqual:[NSNumber numberWithInt:0]]){
            [self displayAlert:[dictionary valueForKey:@"message"]];
        }else{
            txt_comment.text = nil;
            [self GetComments];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:YES];
        NSString *string = @"Cannot estabilish a connection with server";
        [self displayAlert:string];
        
    }];
    
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return commentsArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   TableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"tcell"];
    Comments *ab = [commentsArray objectAtIndex:indexPath.row];
    cell.c_name.text = ab.nam;
    cell.c_sender.text = ab.sender;
    cell.c_date.text = ab.c_date;

    return cell;
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
