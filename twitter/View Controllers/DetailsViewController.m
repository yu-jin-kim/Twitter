//
//  DetailsViewController.m
//  twitter
//
//  Created by yujinkim on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorUsername;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Tweet *tweet = self.tweet;
    User *user = tweet.user;
    self.tweet = tweet;
    self.authorName.text = user.name;
    self.authorUsername.text = [@"@" stringByAppendingString:user.screenName];
    self.dateLabel.text = tweet.createdAtString;
    self.tweetContent.text = tweet.text;
    //convert integer value to strings to display on our cells
    NSString *retweetCountString = [NSString stringWithFormat:@"%i",tweet.retweetCount];
    self.retweetCount.text = retweetCountString;
    NSString *favoriteCountString = [NSString stringWithFormat:@"%i",tweet.favoriteCount];
    self.likeCount.text = favoriteCountString;
    
    [self.profilePicture setImageWithURL:user.profilePictureURL];
    //set different images for different states of buttons
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    
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
    self.likeCount.text = favoriteCountString;
}


@end
