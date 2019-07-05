//
//  TweetCell.h
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "Tweet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN


@protocol TweetCellDelegate;
// TODO: Add required methods the delegate needs to implement

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorUsername;
@property (weak, nonatomic) IBOutlet UILabel *datePublished;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (strong, nonatomic) Tweet *tweet;

- (IBAction)replyPressed:(id)sender;
- (IBAction)favoritePressed:(id)sender;
- (IBAction)retweetPressed:(id)sender;
- (void)refreshData;
- (void) didTapUserProfile:(UITapGestureRecognizer *)sender;


@end

@protocol TweetCellDelegate
- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
@end

NS_ASSUME_NONNULL_END
