//
//  TweetTableViewCell.m
//  goTwitter
//
//  Created by Praveen P N on 6/28/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UIImageView *favImageView;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTweet:(NSDictionary *)tweet {
    self.tweetLabel.text = @"the quick brown fox jumped over the lazy dog.the quick brown fox jumped over the lazy dog.the quick brown fox jumped over the lazy dog 1233.";
//    self.tweetLabel set
}
@end
