//
//  User.m
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        NSString *profilePictureURLString = dictionary[@"profile_image_url_https"];
        self.profilePictureURL = [NSURL URLWithString:profilePictureURLString];
        NSString *profileBannerURLString = dictionary[@"profile_banner_url"];
        self.profileBannerURL = [NSURL URLWithString:profileBannerURLString];
        self.createdAtString = dictionary[@"created_at"];
        self.followersCount = [dictionary[@"followers_count"] intValue];
        self.friendsCount = [dictionary[@"friends_count"] intValue];
        self.userDescription = dictionary[@"description"];
        self.idStr = dictionary[@"id_str"];
    }
    return self;
}

@end
