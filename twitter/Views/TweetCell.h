//
//  TweetCell.h
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePIcture;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorUsername;
@property (weak, nonatomic) IBOutlet UILabel *datePublished;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;

@end

NS_ASSUME_NONNULL_END
