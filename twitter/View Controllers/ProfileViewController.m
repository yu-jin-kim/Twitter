//
//  ProfileViewController.m
//  twitter
//
//  Created by yujinkim on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface ProfileViewController ()< UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweetsArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Tweet *tweet = self.tweet;
    self.userName.text = self.user.name;
    self.userScreenname.text = [@"@" stringByAppendingString:self.user.screenName];
    self.dateJoined.text = self.user.createdAtString;
    self.userDescription.text = self.user.userDescription;
    //convert integer value to strings to display on our cells
    NSString *followersCountString = [NSString stringWithFormat:@"%i",self.user.followersCount];
    self.followersCount.text = followersCountString;
    NSString *friendsCountString = [NSString stringWithFormat:@"%i",self.user.friendsCount];
    self.friendsCount.text = friendsCountString;
    
    [self.profilePicture setImageWithURL:self.user.profilePictureURL];
    [self.profileBanner setImageWithURL:self.user.profileBannerURL];

    //view controller becomes its datasource and delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Get timeline
    [self fetchTweets];
    
    // Cell Heights
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)fetchTweets{
    //we make an api request and it calls the completion handler
    [[APIManager shared] getUserTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweetsArray = [[NSMutableArray alloc] init];
            NSLog(@"😎😎😎 Successfully loaded user timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
                //add each tweet to our mutable array (stores data passed into completion handler)
                [self.tweetsArray addObject:tweet];
            }
            //reload table view
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting user timeline: %@", error.localizedDescription);
        }
        //[self.refreshControl endRefreshing];
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //ask datasource for cellsforrowat
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweetsArray[indexPath.row];
    User *user = self.user;
    cell.tweet = tweet;
    cell.authorName.text = user.name;
    cell.authorUsername.text = [@"@" stringByAppendingString:user.screenName];
    cell.datePublished.text = tweet.createdAtString;
    cell.tweetContent.text = tweet.text;
    //convert integer value to strings to display on our cells
    NSString *replyCountString = [NSString stringWithFormat:@"%i",tweet.replyCount];
    cell.replyCount.text = replyCountString;
    NSString *retweetCountString = [NSString stringWithFormat:@"%i",tweet.retweetCount];
    cell.retweetCount.text = retweetCountString;
    NSString *favoriteCountString = [NSString stringWithFormat:@"%i",tweet.favoriteCount];
    cell.favoriteCount.text = favoriteCountString;
    
    [cell.profilePicture setImageWithURL:user.profilePictureURL];
    //set different images for different states of buttons
    [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    
    //return instance of custom cell with resuse identifier with its elements populated with data at index asked for
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //ask datasource for numberofrows
    //returns number of items returned from API
    return self.tweetsArray.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
