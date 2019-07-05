//
//  ProfileViewController.h
//  twitter
//
//  Created by yujinkim on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UIImageView *profileBanner;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *friendsCount;
@property (weak, nonatomic) IBOutlet UILabel *followersCount;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userScreenname;
@property (weak, nonatomic) IBOutlet UILabel *dateJoined;
@property (weak, nonatomic) IBOutlet UILabel *userDescription;

@end

NS_ASSUME_NONNULL_END
