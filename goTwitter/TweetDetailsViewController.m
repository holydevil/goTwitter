//
//  TweetDetailsViewController.m
//  goTwitter
//
//  Created by Praveen P N on 7/7/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageView+WebCache.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favImageView;


@end

@implementation TweetDetailsViewController

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
    [self showTweet];
    // Do any additional setup after loading the view from its nib.
}

-(void) showTweet {
    NSDictionary *tweet = self.tweet;
    
    self.userNameLabel.text = tweet[@"userName"];
    self.handleLabel.text = [NSString stringWithFormat:@"@%@",tweet[@"userHandle"]];
    self.tweetLabel.text = tweet[@"text"];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet[@"profileImageUrl"]]];
    
    //defaults
    self.replyImageView.image = [UIImage imageNamed:@"reply.png"];
    self.retweetImageView.image = [UIImage imageNamed:@"retweet.png"];
    self.favImageView.image = [UIImage imageNamed:@"favorite.png"];
    //    self.tweetLabel set
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
