//
//  members.h
//  Complete_Project
//
//  Created by adel alahmed on 7/22/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>


//@class register_for_membership;
//@class DonateViewController;

@class rfm_ViewController;
@interface members : UIViewController{

    
    IBOutlet UIImageView *large_bright, *large_dim, *small_bright, *small_dim;
    
    IBOutlet UIButton *reg;
}

@property (nonatomic, retain) rfm_ViewController *r;
@property (nonatomic, retain) IBOutlet UIImageView *large_bright; 
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;
@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim; 

@property (nonatomic, retain) IBOutlet UIButton *reg;

-(IBAction)register_for_membrship:(id)sender;

@end
