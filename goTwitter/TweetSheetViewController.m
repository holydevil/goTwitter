//
//  TweetSheetViewController.m
//  goTwitter
//
//  Created by Praveen P N on 6/28/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TweetSheetViewController.h"

@interface TweetSheetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (strong, nonatomic) UIBarButtonItem *tweetButton;

@end

@implementation TweetSheetViewController

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
//    self.title = @"Tweet";
    //hide the back button. We need a cancel button.
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    //set-up top left cancel button and tweet button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    self.tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(tweetButtonTapped)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = self.tweetButton;
    
    //set focus on textfield
    [self.tweetTextView becomeFirstResponder];
    
    //set delegate property to self
    self.tweetTextView.delegate = self;
}

-(void)cancelButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)tweetButtonTapped {
    NSLog(@"clicked the tweet button");
    // send tweet, wait for ack, and then pop to timeline
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// hide the keyboard when you touch anywhere else
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

// Decide what to do when number of chars change in a tweet
-(void)textViewDidChange:(UITextView *)textView {
    int tweetCount = [self.tweetTextView.text length];
    //set colours for tweet counter based on characters left
    if (tweetCount >= 0) {
        self.tweetCountLabel.textColor = [UIColor blackColor];
        //enable the tweet button
        self.tweetButton.enabled = YES;
    }
    
    if (tweetCount > 120 && tweetCount <= 139) {
        //show orange color
        self.tweetCountLabel.textColor = [UIColor colorWithRed:0.57 green:0.15 blue:0.14 alpha:1];
    }
    
    if (tweetCount >= 140) {
        //show red colour
        self.tweetCountLabel.textColor = [UIColor redColor];
    }
    
    if (tweetCount > 140) {
        tweetCount = 140-tweetCount;
        //disable the tweet button on top right
        self.tweetButton.enabled = NO;
    }
    
    self.tweetCountLabel.text = [NSString stringWithFormat:@"%d",tweetCount];
    
    NSLog(@"%d", tweetCount);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
