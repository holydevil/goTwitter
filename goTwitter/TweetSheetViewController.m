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
@property (weak, nonatomic) IBOutlet UITextField *tweetTextField;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;

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
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(tweetButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = tweetButton;
    
    //set focus on textfiled
    [self.tweetTextField becomeFirstResponder];
    //hide border
    [self.tweetTextField setBorderStyle:UITextBorderStyleNone];
}

-(void)cancelButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)tweetButton {
    NSLog(@"clicked the tweet button");
}

- (IBAction)tweetChanged:(id)sender {
    int tweetCount = [self.tweetTextField.text length];
    //set colours for tweet counter based on characters left
    if (tweetCount >= 0) {
        self.tweetCountLabel.textColor = [UIColor blackColor];
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
