//
//  rfm_ViewController.h
//  Complete_Project
//
//  Created by adel alahmed on 11/9/12.
//  Copyright (c) 2012 nitin.gupta@ongraph.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rfm_ViewController : UIViewController{

    IBOutlet UITextField *fn, *sn, *tn, *ln, *email, *mobile,*account,*dob, *issue_city, *date_of_issue;
    IBOutlet UISegmentedControl *type;
    
}

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
@property (nonatomic,retain) IBOutlet UITextField *account;
- (IBAction)send_request:(id)sender;

@end
