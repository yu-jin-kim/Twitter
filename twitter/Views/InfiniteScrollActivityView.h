//
//  InfiniteScrollActivityView.h
//  twitter
//
//  Created by yujinkim on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteScrollActivityView : UIView

@property (class, nonatomic, readonly) CGFloat defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end
