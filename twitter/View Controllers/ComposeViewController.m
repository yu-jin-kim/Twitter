//
//  ComposeViewController.m
//  twitter
//
//  Created by yujinkim on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "TimelineViewController.h"

@interface ComposeViewController () <UITextViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetTextView.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    int newLength = (int)newText.length;
    self.characterCount.text = [NSString stringWithFormat:@"%d",characterLimit-newLength];
    
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
}


- (IBAction)tweetPressed:(id)sender {
    [[APIManager shared]postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}
- (IBAction)closePressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}



@end
