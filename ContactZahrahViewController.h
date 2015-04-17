//
//  ContactZahrahViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 11/13/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactInfoViewController;
@interface ContactZahrahViewController : UIViewController{
    ContactInfoViewController *cc;

    IBOutlet UILabel *info;
    IBOutlet UIImageView *image_place_holder;
    IBOutlet UIImageView *large_bright, *large_dim, *small_bright, *small_dim;
    
}
@property (nonatomic,retain) ContactInfoViewController *cc;
@property (strong, nonatomic) IBOutlet UILabel *info;
@property (nonatomic, retain) IBOutlet UIImageView *image_place_holder;
@property (nonatomic, retain) IBOutlet UIImageView *large_bright; 
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;
@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim; 

-(IBAction)displayInfo:(id)sender;
-(IBAction)openSite:(id)sender;


@end
