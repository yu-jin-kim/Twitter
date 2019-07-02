//
//  TweetCell.m
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"


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
        [self.retweetButton setSelected:YES];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                self.tweet.retweeted = YES;
                self.tweet.retweetCount += 1;
                NSString *retweetCountString = [NSString stringWithFormat:@"%i",tweet.retweetCount];
                self.retweetCount.text = retweetCountString;
                
            }
        }];
    }
    else{
        [self.retweetButton setSelected:NO];
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                self.tweet.retweeted = NO;
                self.tweet.retweetCount -= 1;
                NSString *retweetCountString = [NSString stringWithFormat:@"%i",tweet.retweetCount];
                self.retweetCount.text = retweetCountString;
            }
        }];
    }
}

- (IBAction)replyPressed:(id)sender {
}


- (IBAction)favoritePressed:(id)sender {
    if(self.tweet.favorited == NO){
        [self.favoriteButton setSelected:YES];
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                self.tweet.favorited = YES;
                self.tweet.favoriteCount += 1;
                NSString *favoriteCountString = [NSString stringWithFormat:@"%i",tweet.favoriteCount];
                self.favoriteCount.text = favoriteCountString;
                
            }
        }];
    }
    else{
        [self.favoriteButton setSelected:NO];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                self.tweet.favorited = NO;
                self.tweet.favoriteCount -= 1;
                NSString *favoriteCountString = [NSString stringWithFormat:@"%i",tweet.favoriteCount];
                self.favoriteCount.text = favoriteCountString;
                
            }
        }];
    }
}






@end
