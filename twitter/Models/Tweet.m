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
        
        // TODO: Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        [dateFormatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
        //convert string to date
        NSDate *date = [dateFormatter dateFromString:createdAtOriginalString];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay) fromDate:date];
        NSInteger hour = [components hour];
        NSInteger minute = [components minute];
        NSInteger second = [components second];
        NSInteger day = [components day];
        
        // Configure output format
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        
        NSDate *timeAgoDateSeconds = [NSDate dateWithTimeIntervalSinceNow:second];
        NSDate *timeAgoDateMinutes = [NSDate dateWithTimeIntervalSinceNow:minute];
        NSDate *timeAgoDateHours = [NSDate dateWithTimeIntervalSinceNow:hour];
        NSDate *timeAgoDateDays = [NSDate dateWithTimeIntervalSinceNow:day];
        
        NSString *stringFromHour = [dateFormatter stringFromDate:timeAgoDateHours];
        NSInteger integerHour = [stringFromHour integerValue];
        NSString *stringFromMin = [dateFormatter stringFromDate:timeAgoDateMinutes];
        NSInteger integerMin = [stringFromMin integerValue];
        NSString *stringFromSec = [dateFormatter stringFromDate:timeAgoDateSeconds];
        NSInteger integerSec = [stringFromSec integerValue];
        NSString *stringFromDay = [dateFormatter stringFromDate:timeAgoDateDays];
        NSInteger integerDay = [stringFromDay integerValue];
        
        // Convert Date to String
        if(integerDay <= 1){
                if(integerMin <= 59){
                    if(integerSec <= 59){
                        self.createdAtString = timeAgoDateSeconds.shortTimeAgoSinceNow;
                    }
                    else{
                        self.createdAtString = timeAgoDateMinutes.shortTimeAgoSinceNow;
                    }
                }
                else{
                    self.createdAtString = timeAgoDateHours.shortTimeAgoSinceNow;
                }
        }
        
        else{
            self.createdAtString = [dateFormatter stringFromDate:date];
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
