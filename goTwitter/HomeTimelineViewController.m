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


@interface HomeTimelineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *homeTimelineTableView;
@property (nonatomic, strong) NSMutableArray *localTimeline;
@end

@implementation HomeTimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDefaults];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Pick up data passed from previous view
-(void)setTimeline:(NSDictionary *)timeline {
    self.localTimeline = [[NSMutableArray alloc]init];

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
        
//        NSLog(@"temp dictionary = %@", tempDictionary);
//        NSLog(@"local timeline = %@", self.localTimeline);
    }

//    self.localTimeline = timeline;
//    NSLog(@"setting local variable for timeline");
    NSLog(@"local timeline is ... %@", self.localTimeline);
    NSLog(@"number of elements in local timeline is ... %d", [self.localTimeline count]);
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
    
    [self.homeTimelineTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"tweetCell"];

    
}

-(void)onTweetButton {
    NSLog(@"tweet button clicked");
    TweetSheetViewController *tweetSheetViewController = [[TweetSheetViewController alloc]init];
    [self.navigationController pushViewController:tweetSheetViewController animated:YES];
}

#pragma mark - Table methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.localTimeline count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"index path row is %ld", (long)indexPath.row];
//    NSLog(@"value at row %d is %@", indexPath.row,self.localTimeline[indexPath.row]);
    
//    NSDictionary *dummyTweet = @{@"user":@"Praveen"};
    cell.tweet = self.localTimeline[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
