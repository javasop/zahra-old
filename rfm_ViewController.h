//
//  rfm_ViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 11/9/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"


@class rfm_choose_type;
@interface rfm_ViewController : UIViewController<UITextFieldDelegate>{

    IBOutlet UITextField *fn, *sn, *tn, *ln, *email, *mobile,*account,*dob, *issue_city, *date_of_issue;
    IBOutlet UISegmentedControl *type, *sub_type;
        IBOutlet UIImageView *large_bright, *large_dim, *small_bright, *small_dim;
    rfm_choose_type *vc;
    AppDelegate *thedelegate;

}

@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (nonatomic,retain) IBOutlet UITextField *fn;
@property (nonatomic,retain) IBOutlet UITextField *sn;
@property (nonatomic,retain) IBOutlet UITextField *tn;
@property (nonatomic,retain) IBOutlet UITextField *ln;
@property (nonatomic,retain) IBOutlet UITextField *email;
@property (nonatomic,retain) IBOutlet UITextField *mobile;
@property (nonatomic,retain) IBOutlet UITextField *dob;
@property (nonatomic,retain) IBOutlet UITextField *issue_city;
@property (nonatomic,retain) IBOutlet UITextField *date_of_issue;
@property (nonatomic,retain) IBOutlet UISegmentedControl *type;
@property (nonatomic,retain) IBOutlet UISegmentedControl *sub_type;
@property (nonatomic,retain) IBOutlet UITextField *account;

- (IBAction)indexChanged:(id)sender;

@property (nonatomic, retain) IBOutlet UIImageView *large_bright; 
@property (nonatomic, retain) IBOutlet UIImageView *large_dim;
@property (nonatomic, retain) IBOutlet UIImageView *small_bright;
@property (nonatomic, retain) IBOutlet UIImageView *small_dim; 

@property (nonatomic, retain) rfm_choose_type *vc;

- (IBAction)send_request:(id)sender;

@end
