//
//  HomeTimelineViewController.m
//  goTwitter
//
//  Created by Praveen P N on 6/28/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import "TweetTableViewCell.h"
#import "TweetSheetViewController.h"
#import "TwitterClient.h"
#import "MBProgressHUD.h"
#import "TweetDetailsViewController.h"


@interface HomeTimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *homeTimelineTableView;
@property (nonatomic, strong) NSMutableArray *localTimeline;

@property UIRefreshControl *refreshControl;
@property MBProgressHUD *hud;
@end

@implementation HomeTimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        [self loadTimeline];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDefaults];
    [self pullToRefresh];
}

// Temp splution to load timeline after posting a tweet
// This always runs when view controller is popped
-(void)viewWillAppear:(BOOL)animated {
    [self loadTimeline];
}

#pragma mark - Pull to Refresh
- (void) pullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(loadTimeline) forControlEvents:UIControlEventValueChanged];
    [self.homeTimelineTableView addSubview:self.refreshControl];
}

#pragma mark - Load twitter timeline
-(void)loadTimeline {
    [self showHUD];
    //If user is logged-in, load timeline
    if ([[TwitterClient instance] isAuthorized]) {
        [[TwitterClient instance] getHomeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self setTimeline:responseObject];
            NSLog(@"in Loadtimeline in HomeTimelineViewController");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Something got messed up in HomeTimelineViewController! Handle this later. %@", error);
        }];
    }
    [self hideHUD];
    
}

#pragma mark - Process tweet data and reload table view
-(void)setTimeline:(NSDictionary *)timeline {
    self.localTimeline = [[NSMutableArray alloc]init];
    [self.localTimeline removeAllObjects];

    //loop through the array of Dictionaries and pick just what we need
    for (NSDictionary *tweet in timeline) {
        // temp dictionary to create a flat dictionary
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]init];
        
        //These are the key=>value we need
        tempDictionary[@"id"] = tweet[@"id"];
        tempDictionary[@"userName"] = [tweet valueForKeyPath:@"user.name"];
        tempDictionary[@"userHandle"] = [tweet valueForKeyPath:@"user.screen_name"];
        tempDictionary[@"createdAt"] = [tweet valueForKeyPath:@"user.created_at"];
        tempDictionary[@"profileImageUrl"] = [tweet valueForKeyPath:@"user.profile_image_url"];
        tempDictionary[@"text"] = tweet[@"text"];
        tempDictionary[@"retweetCount"] = tweet[@"retweet_count"];
        tempDictionary[@"favoriteCount"] = tweet[@"favorite_count"];
        
        //push this flat dictionary to localTimeline array
        [self.localTimeline addObject:tempDictionary];
    }

    NSLog(@"local timeline is ... %@", self.localTimeline);
    NSLog(@"number of elements in local timeline is ... %d", [self.localTimeline count]);
    
    [self.homeTimelineTableView reloadData];
}

#pragma mark - Defaults
-(void)setupDefaults {
    self.homeTimelineTableView.dataSource = self;
    self.homeTimelineTableView.delegate = self;
    self.homeTimelineTableView.rowHeight = 92;
    self.title = @"Home";
    
    //set-up top right button
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    self.navigationItem.rightBarButtonItem = tweetButton;
    
    [self.homeTimelineTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];

    
}

-(void)onTweetButton {
    NSLog(@"'New' button clicked");
    TweetSheetViewController *tweetSheetViewController = [[TweetSheetViewController alloc]init];
    [self.navigationController pushViewController:tweetSheetViewController animated:YES];
}

#pragma mark - Table methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.localTimeline count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    cell.tweet = self.localTimeline[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetDetailsViewController *tweetDetailsViewController = [[TweetDetailsViewController alloc]init];
    tweetDetailsViewController.tweet = self.localTimeline[indexPath.row];
    [self.navigationController pushViewController:tweetDetailsViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Loading icons
- (void) showHUD {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"loading";
    [self.hud show:YES];
}

- (void) hideHUD {
    [self.hud hide:YES];
    
    //stop the pull to refresh loading indicator
    [self.refreshControl endRefreshing];
}


@end
