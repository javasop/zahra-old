//
//  LamsatZaharahIntroductionViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 1/6/13.
//  Copyright (c) 2013 nitin.gupta@ongraph.com. All rights reserved.
//

#import "ViewController.h"
#import "SMViewController.h"
@class SMViewController;
@interface LamsatZaharahIntroductionViewController : UIViewController<UIScrollViewDelegate>{
    SMViewController *sm;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *small_bright, *small_dim, *large_bright, *large_dim, *img;
}

@property (nonatomic, retain) IBOutlet UIImageView *small_bright; 
@property (nonatomic, retain) IBOutlet UIImageView*small_dim;
@property (nonatomic, retain) IBOutlet UIImageView* 
large_bright;

@property (nonatomic, retain) IBOutlet UIImageView* 
img;

@property (nonatomic, retain) IBOutlet UIImageView*large_dim;
@property (nonatomic, retain) IBOutlet UIScrollView *scroll;
-(IBAction)goToStore:(id)sender;
@end
