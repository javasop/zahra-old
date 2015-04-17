//
//  AboutZahrahNewViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 1/6/13.
//  Copyright (c) 2013 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AboutZahrahNewViewController : UIViewController<UIScrollViewDelegate>{

    
    IBOutlet UIScrollView *scroll;
    IBOutlet UIImageView *img;
    IBOutlet UIImageView *small_bright, *small_dim, *large_bright, *large_dim;
}
@property(nonatomic, retain) IBOutlet UIScrollView *scroll;

@property(nonatomic, retain) IBOutlet UIImageView *img;

@property(nonatomic, retain) IBOutlet UIImageView *small_bright; 

@property(nonatomic, retain) IBOutlet UIImageView *small_dim;

@property(nonatomic, retain) IBOutlet UIImageView *large_bright; 

@property(nonatomic, retain) IBOutlet UIImageView *large_dim;

-(IBAction)playVideo:(id)sender;
@end
