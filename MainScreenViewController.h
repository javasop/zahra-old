//
//  MainScreenViewController.h
//  MainScreenApp
//
//  Created by Igor Milakovic on 11/18/12.
//  Copyright (c) 2012 Igor Milakovic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIPageControl *_pageControl;
    IBOutlet UIView *_firstContentView;
    IBOutlet UIView *_secondContentView;
    IBOutlet UIImageView *firstscreen;
}

- (IBAction)firstScreenButtonTapped:(UIButton *)sender;
- (IBAction)secondScreenButtonTapped:(UIButton *)sender;
- (IBAction)pageControlDidChangeValue:(UIPageControl *)sender;

@end
