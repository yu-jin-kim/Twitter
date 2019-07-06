//
//  Tweet.m
//  twitter
//
//  Created by yujinkim on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
#import "DateTools.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.replyCount = [dictionary[@"reply_count"] intValue];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];

        
        // TODO: initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        if ([self.user.screenName isEqualToString:@"mekkaokereke"]){
            NSLog(@"%@", self.text);
        }
        
        // TODO: Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        
        //convert string to date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
        NSDate *convertedDate = [formatter dateFromString:createdAtOriginalString];
        NSDate *todayDate = [NSDate date];
        //NSLog(@"%@", convertedDate);
        //NSLog(@"%@", todayDate);
        double ti = [convertedDate timeIntervalSinceDate:todayDate];
        ti = ti * -1;
        //NSLog(@"%f",ti);
        if (ti < 60) {
            int diff = ti;
            self.createdAtString = [NSString stringWithFormat:@"%ds", diff];
        } else if (ti < 3600) {
            int diff = round(ti / 60);
            self.createdAtString = [NSString stringWithFormat:@"%dm", diff];
        } else if (ti < 86400) {
            int diff = round(ti / 60 / 60);
            self.createdAtString = [NSString stringWithFormat:@"%dh", diff];
        } else if (ti < 2629743) {
            int diff = round(ti / 60 / 60 / 24);
            self.createdAtString = [NSString stringWithFormat:@"%dd", diff];
        } else {
            self.createdAtString = [formatter stringFromDate:date];
        }
    }
    return self;
    
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}



@end
