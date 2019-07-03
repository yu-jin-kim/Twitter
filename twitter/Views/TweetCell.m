//
//  TweetCell.m
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

//we define a custom table view cell and set its reuse identifier on our storyboard
@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)retweetPressed:(id)sender {
    if(self.tweet.retweeted == NO){
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self.retweetButton setSelected:YES];
                self.tweet = tweet;
                self.tweet.retweeted = YES;
                self.tweet.retweetCount += 1;
                [self refreshData];
                
            }
        }];
    }
    else{
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                [self.retweetButton setSelected:NO];
                self.tweet = tweet;
                self.tweet.retweeted = NO;
                self.tweet.retweetCount -= 1;
                [self refreshData];
            }
        }];
    }
}

- (IBAction)replyPressed:(id)sender {
}


- (IBAction)favoritePressed:(id)sender {
    if(self.tweet.favorited == NO){
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self.favoriteButton setSelected:YES];
                self.tweet = tweet;
                self.tweet.favorited = YES;
                self.tweet.favoriteCount += 1;
                [self refreshData];
                
            }
        }];
    }
    else{
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                [self.favoriteButton setSelected:NO];
                self.tweet = tweet;
                self.tweet.favorited = NO;
                self.tweet.favoriteCount -= 1;
                [self refreshData];
            }
        }];
    }
}


- (void)refreshData{
    NSString *retweetCountString = [NSString stringWithFormat:@"%i",self.tweet.retweetCount];
    self.retweetCount.text = retweetCountString;
    NSString *favoriteCountString = [NSString stringWithFormat:@"%i",self.tweet.favoriteCount];
    self.favoriteCount.text = favoriteCountString;
}



@end
