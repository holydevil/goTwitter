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
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"index path row is %ld", (long)indexPath.row];
    
    NSDictionary *dummyTweet = @{@"user":@"Praveen"};
    cell.tweet = dummyTweet;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
