//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
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

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *tweetsArray;
//view controller has a tableview as a subview
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end


@implementation TimelineViewController

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // TODO: Perform segue to profile view controller
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

- (IBAction)logOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //view controller becomes its datasource and delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // Get timeline
    [self fetchTweets];
    
    // Cell Heights
    //self.tableView.rowHeight = 138.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //Implement pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
}

- (void)fetchTweets{
    //we make an api request and it calls the completion handler
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweetsArray = [[NSMutableArray alloc] init];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                //NSString *text = tweet.text;
                //NSLog(@"%@", text);
                //add each tweet to our mutable array (stores data passed into completion handler)
                [self.tweetsArray addObject:tweet];
            }
            //reload table view
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //ask datasource for cellsforrowat
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweetsArray[indexPath.row];
    User *user = tweet.user;
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
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //ask datasource for numberofrows
    //returns number of items returned from API
    return self.tweetsArray.count;
}

- (void)didTweet:(Tweet *)tweet{
    //add new composed tweet to our mutable array and reload data
    [self.tweetsArray addObject:tweet];
    [self fetchTweets];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"composeSegue"]){
        //prepare for segue into compose view controller
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    else if ([[segue identifier] isEqualToString:@"profileSegue"]){
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.user = sender;
    }
    else{
        //prepare for segue into details view controller
        TweetCell *tappedCell = sender;
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = tappedCell.tweet;
    }
}





@end
