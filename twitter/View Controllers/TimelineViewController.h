//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"

@interface TimelineViewController : UIViewController<TweetCellDelegate>

- (void)didTweet:(Tweet *)tweet;

@end
