//
//  ComposeViewController.h
//  twitter
//
//  Created by yujinkim on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;
@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;




@end

NS_ASSUME_NONNULL_END
