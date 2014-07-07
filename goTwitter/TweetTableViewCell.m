//
//  TweetTableViewCell.m
//  goTwitter
//
//  Created by Praveen P N on 6/28/14.
//  Copyright (c) 2014 Yahoo Inc. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+DateTools.h"

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
    self.tweetLabel.text = tweet[@"text"];
    self.userNameLabel.text = tweet[@"userName"];
    self.handleLabel.text = [NSString stringWithFormat:@"@%@",tweet[@"userHandle"]];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:tweet[@"profileImageUrl"]]];
    self.durationLabel.text = [self getRelativeDateFor:tweet[@"createdAt"]];
}

#pragma mark - Defaults (move them to a different file)
-(NSString *)getRelativeDateFor: (NSString *) date {
//    NSLog(@"input date is %@", date);
    //convert string to date object
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *returndate = [dateFormatter dateFromString:date];
    
    //use method from NSDate+DateTools.h to send timeSinceNow
    return returndate.shortTimeAgoSinceNow;
}


#pragma mark - variable height for table cells
- (void)layoutSubviews {
    // Fix the issue where text height is wrong for multi-line text
    // (Especially when 3 lines of text, it introduces padding at upper and lower edges).
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.tweetLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.tweetLabel.frame);
}

@end
