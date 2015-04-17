//
//  DonateViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 11/8/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonateViewController : UIViewController{

    
    IBOutlet UIImageView *small_bright, *large_bright, *small_dim, *large_dim;
}

@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim;
@property (nonatomic, retain) IBOutlet UIImageView *large_bright;
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;


- (IBAction)sms:(id)sender;


@end
