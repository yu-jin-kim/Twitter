//
//  User.h
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profilePictureURL;
@property (strong, nonatomic) NSURL *profileBannerURL;
@property (strong, nonatomic) NSString *createdAtString;
@property (nonatomic) int followersCount;
@property (nonatomic) int friendsCount;
@property (strong, nonatomic) NSString *userDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
